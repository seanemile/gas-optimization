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
  So, instead of:

```solidity

```

---

## Tip: Cache array length outside of loop

Description: If array length is not cached outside loop, the solidity compiler will always read the length of the array during each iteration. That is, if it is a storage array, this is an extra sload operation (100 additional extra gas for each iteration except for the first) and if it is a memory array, this is an extra mload operation (3 additional gas for each iteration except for the first).

Proof of Concept:

```solidity

```

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
