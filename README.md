## Gas Optimization by example:

---

### Tip 1. Use smaller types than uint256 and Pack your variables!

- Example: You don't need 256 bits to represent a timestamp, 32 bits are enough. Remember to use SafeCast to avoid overflow when casting.
  [Tip1.sol]()

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {SafeCast} from "openzeppelin-contracts/utils/math/SafeCast.sol";

contract Tip1 {
    using SafeCast for uint256;
    uint32 public timestamp;

    /**
     * @dev Leaves 28 bytes(uint 224) of space after the slot.
     * @custom:variable Timestamp is equal to ( 2^32 - 1 ) which is approximately 100 years from now. should be enough for your needs
     */

    function setTime(uint256 value) public {
        timestamp = value.toUint32();
    }
}
```

---

### Tip 2. Cache frequently used Storage variable, Mapping Structs

Caching a mapping’s value in a local storage variable when the value is accessed multiple times, saves ~42 gas per access due to not having to recalculate the key’s keccak256 hash (Gkeccak256 - 30 gas) and that calculation’s associated stack operations. Caching an array’s struct avoids recalculating the array offsets into memory)

So, instead of foo1() use foo2():
[Tip2.sol]()

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
contract Tip2 {
    uint256 public variable1 = 5;
    mapping(uint256 => uint256) public variable2;

    function foo1(uint256 someNum) external {
        variable2[variable1] = someNum;
    }

    function foo2(uint256 someNum) external {
        uint256 tempBar = variable1; // tempBar is in memory and cheaper to read from
        variable2[variable1] = someNum;
    }
}
```

![Gas Usage](/assets/image1.png).

---

### Tip 3. Declare Constructor as payable.

- Description: You eliminate the payable check. Saving gas during deployment.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
contract Tip3a {
    uint256 public variable1;

    constructor() payable {
        variable1 = 5;
    }
}
```

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
contract Tip3b {
    uint256 public variable1;

    constructor() {
        variable1 = 5;
    }
}
```

![Gas Usage](/assets/image2.png).
![Gas Usage](/assets/image3.png).

---

### Tip: 4. Upgrade at least 0.8.4

Using newer compiler versions and the optimizer gives gas
optimizations and additional safety checks for free!

The advantages of versions =0.8.\*= over =<0.8.0= are:

- Safemath by default from =0.8.0= (can be more gas efficient than /some/
  library based safemath).
- [[https://blog.soliditylang.org/2021/03/02/saving-gas-with-simple-inliner/][Low level inliner]] from =0.8.2=, leads to cheaper runtime gas.
  Especially relevant when the contract has small functions. For
  example, OpenZeppelin libraries typically have a lot of small
  helper functions and if they are not inlined, they cost an
  additional 20 to 40 gas because of 2 extra =jump= instructions and
  additional stack operations needed for function calls.
- [[https://blog.soliditylang.org/2021/03/23/solidity-0.8.3-release-announcement/#optimizer-improvements][Optimizer improvements in packed structs]]: Before =0.8.3=, storing
  packed structs, in some cases used an additional storage read
  operation. After [[https://eips.ethereum.org/EIPS/eip-2929][EIP-2929]], if the slot was already cold, this
  means unnecessary stack operations and extra deploy time costs.
  However, if the slot was already warm, this means additional cost
  of =100= gas alongside the same unnecessary stack operations and
  extra deploy time costs.
- [[https://blog.soliditylang.org/2021/04/21/custom-errors][Custom errors]] from =0.8.4=, leads to cheaper deploy time cost and
  run time cost. Note: the run time cost is only relevant when the
  revert condition is met. In short, replace revert strings by
  custom errors.

---

### Tip: 5. Caching the length in for loops:

Example:

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Array {
    uint256[10] public number;

    ///@notice Looping over a storage array: Without cache
    function loop1() public view {
        for (uint256 i; i < number.length;) {
            ++i;
        }
    }

    ///@notice Looping over a storage array with cached length outside of the loop
    function loop2() public view {
        uint256 length = number.length;
        for (uint256 i; i < length;) {
            ++i;
        }
    }

    ///@notice Looping over a memory array without cached length
    function loop3() public pure {
        uint256[] memory num1 = new uint256[](10);
        for (uint256 i; i < num1.length;) {
            ++i;
        }
    }

    ///@notice Looping over a storage array with cached length outside of the loop
    function loop4() public pure {
        uint256[] memory num1 = new uint256[](10);
        uint256 length = num1.length;
        for (uint256 i; i < length;) {
            ++i;
        }
    }
}
```

via_ir=false optimization=200
![Gas Usage](/assets/image4.png)

via_ir=false optimization=1000
![Gas Usage](/assets/image5.png)

via_ir=true optimization=200
![Gas Usage](/assets/image6.png)

via_ir=true optimization=1000
![Gas Usage](/assets/image7.png)

---

### Tip 6: Use calldata instead of memory for function arguments that don't get mutated

Gas savings: In the former example, the ABI decoding begins with copying value from calldata to memory in a for loop. Each iteration would cost at least 60 gas. In the latter example, this can be completely avoided. This will also reduce the number of instructions and therefore reduces the deploy time cost of the contract.

```solidity

// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Tip6 {
    function add1(uint256[] memory arr) external pure returns (uint256 sum) {
        uint256 length = arr.length;
        for (uint256 i = 0; i < length; i++) {
            sum += arr[i];
        }
    }

    function add2(uint256[] calldata arr) external pure returns (uint256 sum) {
        uint256 length = arr.length;
        for (uint256 i = 0; i < length; i++) {
            sum += arr[i];
        }
    }
}
```

via_ir=false optimization=200
![Gas Usage](/assets/image9.png)

via_ir=true optimization=200
![Gas Usage](/assets/image8.png)

---

### Tip 7: Use IR(yul) compiler pipeline

Notice through the sample code the effects of turning on IR

---

### Tip 8: Consider using custom errors instead of revert strings.

Solidity 0.8.4 introduced custom errors. They are more gas efficient than revert strings, when it comes to deploy cost as well as runtime cost when the revert condition is met. Use custom errors instead of revert strings for gas savings.

---

### Tip 9: Use immutable State variables where applicable

Example, each call to the function owner1() reads from storage, using a sload. After EIP-2929, this costs 2100 gas cold or 100 gas warm. However owner2() is more gas efficient:

```solidity
// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Tip9 {
    /// The owner is set during construction time, and never changed afterwards.
    address public owner1 = msg.sender;

    /// The owner is set during construction time, and never changed afterwards.
    address public immutable owner2 = msg.sender;
}
```

via_ir=true optimization=200
![Gas Usage](/assets/image10.png)

---

### Tip 10: Use short revert strings.

---

### Tip 11: Use bytes32 rather string/bytes (fixed sizes are always cheaper).

---

### Tip 12: Function modifiers can be inefficient

The code of modifiers is inlined inside the
modified function, thus adding up size and
costing gas.
Limit the modifiers. Internal functions are not
inlined, but called as separate functions. They
are slightly more expensive at run time, but
save a lot of redundant bytecode in
deployment, if used more than once

---

### Tip 13: No need to initialize variables with default values

In Solidity, all variables are set to zeroes by
default. So, do not explicitly initialize a
variable with its default value if it is zero.

---

### Tip 14: Avoid repetitive checks eg using safe math library

---

### Tip 15: Using `private` visibility rather than `public` for constants

If needed, the value can be read from the verified contract source code. Savings are due to the compiler not having to create non-payable getter functions for deployment calldata, and not adding another entry to the method ID table)

---

### Tip 16: Usage of UINT/INTS smaller than 32 bytes (256 bits) incurs overhead

When using elements that are smaller than 32 bytes, your contract’s gas usage may be higher. This is because the EVM operates on 32 bytes at a time. Therefore, if the element is smaller than that, the EVM must use more operations in order to reduce the size of the element from 32 bytes to the desired size.)

---

### Tip 17. ++I costs less gas than I++, especially when It's used in for-loops

---

### Tip 18. Calling internal functions is cheaper

---

### Tip 19. Calling internal functions is cheaper

Calling public functions is more expensive than
calling internal functions, because in the former
case all the parameters are copied into Memory.

Whenever possible, prefer internal function
calls, where the parameters are passed as
references.

---

### Tip 20. uint\*(8/16/32..) vs uint256

TheEVM run on 256 bits at a time thus using a unit\* it will firs be converted to unt256 and it cost extra gas)

The EVM run on 256 bits at a time, thus using
an uint\* (unsigned integers smaller than 256
bits), it will first be converted to uint256 and it
costs extra gas.

Use unsigned integers smaller or equal than
128 bits when packing more variables in one
slot (see Variables Packing pattern). If not, it
is better to use uint256 variables.

---

### Tip 21. AVOID CONTRACT EXISTENCE CHECKS BY USING SOLIDITY VERSION 0.8.10 OR LATER

Prior to 0.8.10 the compiler inserted extra code, including EXTCODESIZE (700 gas), to check for contract existence for external calls. In more recent solidity versions, the compiler will not insert these checks if the external call has a return value)

---

### Tip 22. Using ``boolean` for storage incurs overhead

Booleans are more expensive than uint256 or any type that takes up a full
// word because each write operation emits an extra SLOAD to first read the
// slot's contents, replace the bits taken up by the boolean, and then write
// back. This is the compiler's defense against contract upgrades and
// pointer aliasing, and it cannot be disabled.) (Use uint256(1) and uint256(2) for true/false to avoid a Gwarmaccess (100 gas) for the extra SLOAD, and to avoid Gsset (20000 gas) when changing from ‘false’ to ‘true’, after having been ‘true’ in the past)

---

### Tip 23. The increment in for loop post condition can be made unchecked

(This is only relevant if you are using the default solidity checked arithmetic.)

Consider the following generic for loop:

for (uint i = 0; i < length; i++) {
// do something that doesn't change the value of i
}
In this example, the for loop post condition, i.e., i++ involves checked arithmetic, which is not required. This is because the value of i is always strictly less than length <= 2**256 - 1. Therefore, the theoretical maximum value of i to enter the for-loop body is 2**256 - 2. This means that the i++ in the for loop can never overflow. Regardless, the overflow checks are performed by the compiler.

Unfortunately, the Solidity optimizer is not smart enough to detect this and remove the checks. One can manually do this by:

for (uint i = 0; i < length; i = unchecked_inc(i)) {
// do something that doesn't change the value of i
}

function unchecked_inc(uint i) returns (uint) {
unchecked {
return i + 1;
}
}
Note that it’s important that the call to unchecked_inc is inlined. This is only possible for solidity versions starting from 0.8.2.

Gas savings: roughly speaking this can save 30-40 gas per loop iteration. For lengthy loops, this can be significant!

---

### Tip 24: external functions are cheaper than public:

The input parameters of public functions are
copied to memory automatically, and this costs
gas.

The input parameters of external functions are
read right from Calldata memory. Therefore,
explicitly mark as external functions called
only externally

### Tip 25: Mapping vs Array

Solidity provides only two data types to
represents list of data: arrays and maps.
Mappings are cheaper, while arrays are
packable and iterable

In order to save gas, it is recommended to use
mappings to manage lists of data, unless there
is a need to iterate or it is possible to pack data
types. This is useful both for Storage and
Memory. You can manage an ordered list with
a mapping using an integer index as a key

### Tip 26: Avoid redundant operations

Avoid redundant operations. For instance,
avoid double checks; the use of SafeMath
library prevents underflow and overflow, so
there is no need to check for them.

### Tip 27: Freeing storage

To help keeping the size of the blockchain
smaller, you get a gas refund every time you
free the Storage. Therefore, it is convenient to
delete the variables on the Storage, using the
keyword delete, as soon as they are no longer
necessary.

### Tip 28: Use assembly to check for address(0)

### References:

https://gist.github.com/hrkrshnn/ee8fabd532058307229d65dcd5836ddc <br>
https://forum.openzeppelin.com/t/a-collection-of-gas-optimisation-tricks/19966

---
