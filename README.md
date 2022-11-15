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

### Tip 2. Cache frequently used Storage variable.

- Description: If there's a state variable you'll read from more than once in a function, it's best to cast it into memory.
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

### Tip 6: Use calldata instead of memory for function parameters

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

### References:

https://gist.github.com/hrkrshnn/ee8fabd532058307229d65dcd5836ddc <br>
https://forum.openzeppelin.com/t/a-collection-of-gas-optimisation-tricks/19966

---

Gas report:

2. Use bytes32 rather than string/bytes(Fixed Size)

3. Function modifiers can be inefficient

4. Use libraries to save some bytecode

5. No need to initialize variables with default values

6. Use short reason stings.(Every reason string takes at least 32 bytes so make sure your string fits in 32 bytes or it will become more expensive.)

7. Avoid repetitive checks eg using safe math library

8. Make proper use of the optimizer

9. Calling internal functions is cheaper

10. uint* vs uint256 (TheEVM run on 256 bits at a time thus using a unit* it will firs be converted to unt256 and it cost extra gas)

11. use global variable constants where applicable.

12. AVOID CONTRACT EXISTENCE CHECKS BY USING SOLIDITY VERSION 0.8.10 OR LATER (Prior to 0.8.10 the compiler inserted extra code, including EXTCODESIZE (700 gas), to check for contract existence for external calls. In more recent solidity versions, the compiler will not insert these checks if the external call has a return value)

13. MULTIPLE ACCESSES OF A MAPPING/ARRAY SHOULD USE A LOCAL VARIABLE CACHE (Caching a mapping’s value in a local storage variable when the value is accessed multiple times, saves ~42 gas per access due to not having to recalculate the key’s keccak256 hash (Gkeccak256 - 30 gas) and that calculation’s associated stack operations. Caching an array’s struct avoids recalculating the array offsets into memory)

14. USING BOOLS FOR STORAGE INCURS OVERHEAD(Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.) (Use uint256(1) and uint256(2) for true/false to avoid a Gwarmaccess (100 gas) for the extra SLOAD, and to avoid Gsset (20000 gas) when changing from ‘false’ to ‘true’, after having been ‘true’ in the past)

15. 0.8.4 to get custom errors, which are cheaper at deployment than revert()/require() strings

16. ++I COSTS LESS GAS THAN I++, ESPECIALLY WHEN IT’S USED IN FOR-LOOPS

17. USAGE OF UINTS/INTS SMALLER THAN 32 BYTES (256 BITS) INCURS OVERHEAD (When using elements that are smaller than 32 bytes, your contract’s gas usage may be higher. This is because the EVM operates on 32 bytes at a time. Therefore, if the element is smaller than that, the EVM must use more operations in order to reduce the size of the element from 32 bytes to the desired size.)

18. USING PRIVATE RATHER THAN PUBLIC FOR CONSTANTS, SAVES GAS (If needed, the value can be read from the verified contract source code. Savings are due to the compiler not having to create non-payable getter functions for deployment calldata, and not adding another entry to the method ID table)

19. increase the number of optimizations.

[20]-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Issue: Array length used in loop.

Description: If array length is not cached outside loop, the solidity compiler will always read the length of the array during each iteration. That is, if it is a storage array, this is an extra sload operation (100 additional extra gas for each iteration except for the first) and if it is a memory array, this is an extra mload operation (3 additional gas for each iteration except for the first).

Mitigation: Cache array length outside of loop

Count:

Location:

Gas Savings:

---
