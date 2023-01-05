Table of content:
- [Installation](#installation)
  - [SetUp](#setup)
  - [Run Tests](#run-tests)
- [Gas Optimization tips:](#gas-optimization-tips)
  - [GAS-1: Use smaller types than uint256 and Pack your variables!](#gas-1-use-smaller-types-than-uint256-and-pack-your-variables)
  - [GAS-2: Cache frequently used Storage variable, Mapping Structs](#gas-2-cache-frequently-used-storage-variable-mapping-structs)
  - [GAS-3: Declare Constructor as payable.](#gas-3-declare-constructor-as-payable)
  - [GAS-4: Upgrade at least 0.8.4](#gas-4-upgrade-at-least-084)
  - [GAS-5: Caching array length outside of loop.](#gas-5-caching-array-length-outside-of-loop)
  - [GAS-6: Use calldata instead of memory for function arguments that don't get mutated](#gas-6-use-calldata-instead-of-memory-for-function-arguments-that-dont-get-mutated)
  - [GAS-7: Use IR(yul) compiler pipeline](#gas-7-use-iryul-compiler-pipeline)
  - [GAS-8: Consider using custom errors instead of revert strings.](#gas-8-consider-using-custom-errors-instead-of-revert-strings)
  - [GAS-9: Use immutable State variables where applicable](#gas-9-use-immutable-state-variables-where-applicable)
  - [GAS-10: Use short revert strings.](#gas-10-use-short-revert-strings)
  - [GAS-11: Use bytes32 rather string/bytes (fixed sizes are always cheaper).](#gas-11-use-bytes32-rather-stringbytes-fixed-sizes-are-always-cheaper)
  - [GAS-12: Function modifiers can be inefficient](#gas-12-function-modifiers-can-be-inefficient)
  - [GAS-13: No need to initialize variables with default values](#gas-13-no-need-to-initialize-variables-with-default-values)
  - [GAS-14: Avoid repetitive checks eg using safe math library](#gas-14-avoid-repetitive-checks-eg-using-safe-math-library)
  - [GAS-15: Using `private` visibility rather than `public` for constants](#gas-15-using-private-visibility-rather-than-public-for-constants)
  - [GAS-16: Usage of UINT/INTS smaller than 32 bytes (256 bits) incurs overhead](#gas-16-usage-of-uintints-smaller-than-32-bytes-256-bits-incurs-overhead)
  - [GAS-17: ++i costs less gas than i++, especially when It's used in for-loops.(--i/i-- too)](#gas-17-i-costs-less-gas-than-i-especially-when-its-used-in-for-loops--ii---too)
  - [GAS-18: array\[index\] += amount is cheaper than array\[index\] = array\[index\] + amount (or related variants)](#gas-18-arrayindex--amount-is-cheaper-than-arrayindex--arrayindex--amount-or-related-variants)
  - [GAS-19: Calling internal functions is cheaper](#gas-19-calling-internal-functions-is-cheaper)
  - [GAS-20: uint\*(8/16/32..) vs uint256](#gas-20-uint81632-vs-uint256)
  - [GAS-21: Avoid contract existence checks by using version 0.8.10 or Later](#gas-21-avoid-contract-existence-checks-by-using-version-0810-or-later)
  - [GAS-22: Using \`\`boolean\` for storage incurs overhead](#gas-22-using-boolean-for-storage-incurs-overhead)
  - [GAS-23: The increment in for loop post condition can be made unchecked](#gas-23-the-increment-in-for-loop-post-condition-can-be-made-unchecked)
  - [GAS-24: external functions are cheaper than public:](#gas-24-external-functions-are-cheaper-than-public)
  - [GAS-25: Mapping vs Array](#gas-25-mapping-vs-array)
  - [GAS-26: Avoid redundant operations](#gas-26-avoid-redundant-operations)
  - [GAS-27: Freeing storage](#gas-27-freeing-storage)
  - [GAS-28: Use assembly to check for address(0)](#gas-28-use-assembly-to-check-for-address0)
  - [GAS-29 Use != 0 instead of \> 0 for unsigned integer comparison](#gas-29-use--0-instead-of--0-for-unsigned-integer-comparison)
  - [References](#references)

# Installation
## SetUp
You will need a copy of [Foundry](https://github.com/foundry-rs/foundry) installed before proceeding. See the [Installation guide](https://github.com/foundry-rs/foundry#installation) for more details. 
```bash
 $ git clone https://github.com/seanemile/gas-optimization
 $ cd gas-optimization
 $ forge install
```
## Run Tests
All the tests
```bash
$ forge test
```
Match a specific test
```bash
$ forge test --match-contract ContractName.sol
```
Update Gas Snapshots
```bash
$ forge snapshot
```
# Gas Optimization tips: 
<!--GAS-1 Tip -->
## GAS-1: Use smaller types than uint256 and Pack your variables!
- Description: You don't need 256 bits to represent a timestamp, 32 bits are enough. Remember to use SafeCast to avoid overflow when casting
- Example: [Tip.sol](https://github.com/seanemile/gas-optimization/blob/main/src/Tip1.sol)

```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity 0.8.17;
    import 	{;SafeCast}; from "openzeppelin-contracts/utils/math/SafeCast.sol";
    contract Tip1	 {;
      using SafeCast for uint256;
      uint32 public timestamp;
      /**
      * @dev Leaves 28 bytes(uint 224) of space after the slot.
      * @custom:variable Timestamp is equal to ( 2^32 - 1 ) which is approximately 100 years from now. should be enough for your needs
      */
       function setTime(uint256 value) public {;
         timestamp = value.toUint32();
        };
      &#126;
```
## GAS-2: Cache frequently used Storage variable, Mapping Structs
<!--GAS-2 Tip -->
- Description: Cache a mapping's value in a local storage variable when the value is accessed multiple times, saves ~42 gas per access due to not having to recalculate the key's keccak256 hash (Gkeccak256 - 30 gas) and that calculation's associated stack operations. Caching an array's struct avoids recalculating the array offsets into memory)

- Storage variable:The instances below point to the second+ access of a state variable within a function. Caching of a state variable replaces each Gwarmaccess (100 gas) with a much cheaper stack read. Other less obvious fixes/optimizations include having local memory caches of state variable structs, or having local caches of state variable contracts/addresses.
- Example: [Tip2.sol](https://github.com/seanemile/gas-optimization/blob/main/src/Tip2.sol)

```solidity
```

| contracts/contract/Storage.sol:Storage contract |                 |       |        |       |         |
|-------------------------------------------------|-----------------|-------|--------|-------|---------|
| Deployment Cost                                 | Deployment Size |       |        |       |         |
| 1091309                                         | 5416            |       |        |       |         |
| Function Name                                   | min             | avg   | median | max   | # calls |
| addUint                                         | 21084           | 21084 | 21084  | 21084 | 3       |
| confirmGuardian                                 | 3980            | 3980  | 3980   | 3980  | 1       |
| getAddress                                      | 537             | 537   | 537    | 537   | 3       |
| getBool                                         | 539             | 1872  | 2539   | 2539  | 9       |
| getGuardian                                     | 365             | 476   | 365    | 2365  | 18      |
| getInt                                          | 527             | 527   | 527    | 527   | 1       |
| getString                                       | 1439            | 1439  | 1439   | 1439  | 1       |
| getUint                                         | 549             | 1749  | 2549   | 2549  | 15      |
| setAddress                                      | 23054           | 23175 | 23185  | 23185 | 42      |
| setBool                                         | 4706            | 22620 | 23113  | 25113 | 52      |
| setGuardian                                     | 22722           | 22722 | 22722  | 22722 | 1       |
| setInt                                          | 2902            | 18991 | 27036  | 27036 | 3       |
| setString                                       | 23634           | 23684 | 23634  | 25634 | 40      |
| setUint                                         | 1012            | 13804 | 22881  | 23012 | 117     |

## GAS-3: Declare Constructor as payable.
<!--GAS-3 Tip -->
- Description: You eliminate the payable check. Saving gas during deployment.
- Example: [Tip3a.sol](https://github.com/seanemile/gas-optimization/blob/main/src/Tip3a.sol) and [Tip3b.sol](https://github.com/seanemile/gas-optimization/blob/main/src/Tip3b.sol)

```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity 0.8.17;
    uint public variable1;

    contract Tip3a {;
      constructor() payable {;
        variable1 = 5;
      };
    };

    contract Tip3b {;
      constructor() {;
        variable1 = 5;
      };
    };
```
## GAS-4: Upgrade at least 0.8.4
<!--GAS-4 Tip -->
- Description: Using newer compiler versions and the optimizer gives gas optimizations and additional safety checks for free!. Advantages of versions =0.8.\*= over =<0.8.0= are:
1. SafeMath by default from =0.8.0= (can be more gas efficient than some library based SafeMath). [[https://blog.soliditylang.org/2021/03/02/saving-gas-with-simple-inliner/][Low level inliner]] from =0.8.2=, leads to cheaper runtime gas. Especially relevant when the contract has small functions. For example, OpenZeppelin libraries typically have a lot of small helper functions and if they are not inlined, they cost an additional 20 to 40 gas because of 2 extra =jump= instructions and additional stack operations needed for function calls. -
2. [[https://blog.soliditylang.org/2021/03/23/solidity-0.8.3-release-announcement/#optimizer-improvements][Optimizer improvements in packed structs]]: Before =0.8.3=, storing packed structs, in some cases used an additional storage read operation. After [[https://eips.ethereum.org/EIPS/eip-2929][EIP-2929]], if the slot was already cold, this means unnecessary stack operations and extra deploy time costs. However, if the slot was already warm, this means additional cost of =100= gas alongside the same unnecessary stack operations and extra deploy time costs. -
3. [[https://blog.soliditylang.org/2021/04/21/custom-errors][Custom errors]] from =0.8.4=, leads to cheaper deploy time cost and run time cost. Note: the run time cost is only relevant when the revert condition is met. In short, replace revert strings by custom errors.

     
## GAS-5: Caching array length outside of loop.
<!--GAS-5 Tip -->
- Description If not cached, the solidity compiler will always read the length of the array during each iteration. That is, if it is a storage array, this is an extra sload operation (100 additional extra gas for each iteration except for the first) and if it is a memory array, this is an extra mload operation (3 additional gas for each iteration except for the first).
- Example
```solidity
  for (uint i = 0; i < dest.length;)
```
## GAS-6: Use calldata instead of memory for function arguments that don't get mutated
<!--GAS-6 Tip -->
- Description: Gas savings: In the former example, the ABI decoding begins with copying value from calldata to memory in a for loop. Each iteration would cost at least 60 gas. In the latter example, this can be completely avoided. This will also reduce the number of instructions and therefore reduces the deploy time cost of the contract.

```solidity
   // SPDX-License-Identifier: MIT
   pragma solidity 0.8.17;
   contract Tip6 {;

    function add1(uint256[] memory arr) external pure returns (uint256 sum) {;
      uint256 length = arr.length;
      for (uint256 i = 0; i < length; i++) {;
       sum += arr[i];
      };
    };

    function add2(uint256[] calldata arr) external pure returns (uint256 sum) {;
      uint256 length = arr.length;
      for (uint256 i = 0; i < length; i++) {;
        sum += arr[i];
      };
    };
  };
```

via_ir=false optimization=200
via_ir=true optimization=200
     
## GAS-7: Use IR(yul) compiler pipeline
<!--GAS-7 Tip -->
Description: Notice through the sample code the effects of turning on IR ---
     

## GAS-8: Consider using custom errors instead of revert strings.
<!--GAS-8 Tip -->
- Description: Solidity 0.8.4 introduced custom errors. They are more gas efficient than revert strings, when it comes to deploy cost as well as runtime cost when the revert condition is met. Use custom errors instead of revert strings for gas savings.[source](https://blog.soliditylang.org/2021/04/21/custom-errors/)
     
## GAS-9: Use immutable State variables where applicable
<!--GAS-9 Tip -->
- Description: Example, each call to the function owner1() reads from storage, using a sload. After EIP-2929, this costs 2100 gas cold or 100 gas warm. However owner2() is more gas efficient:

```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity 0.8.17;
    contract Tip9 {;
      /// The owner is set during construction time, and never changed afterwards.
      address public owner1 = msg.sender;
      /// The owner is set during construction time, and never changed afterwards.
      address public immutable owner2 = msg.sender;
    };
```
via_ir=true optimization=200

## GAS-10: Use short revert strings.
<!--GAS-10 Tip -->

## GAS-11: Use bytes32 rather string/bytes (fixed sizes are always cheaper).
<!--GAS-11 Tip -->
      
## GAS-12: Function modifiers can be inefficient
<!--GAS-12 Tip -->
- Description: The code of modifiers is inlined inside the modified function, thus adding up size and costing gas. Limit the modifiers. Internal functions are not inlined, but called as separate functions. They are slightly more expensive at run time, but save a lot of redundant bytecode in deployment, if used more than once

## GAS-13: No need to initialize variables with default values
<!--GAS-13 Tip -->
- Description: In Solidity, all variables are set to zeroes by default. So, do not explicitly initialize a variable with its default value if it is zero.
     
## GAS-14: Avoid repetitive checks eg using safe math library
<!--GAS-14 Tip -->

## GAS-15: Using `private` visibility rather than `public` for constants
<!--GAS-15 Tip -->
- Description If needed, the value can be read from the verified contract source code. Savings are due to the compiler not having to create non-payable getter functions for deployment calldata, and not adding another entry to the method ID table)
     
## GAS-16: Usage of UINT/INTS smaller than 32 bytes (256 bits) incurs overhead
<!--GAS-16 Tip -->

- Description: When using elements that are smaller than 32 bytes, your contract's gas usage may be higher. This is because the EVM operates on 32 bytes at a time. Therefore, if the element is smaller than that, the EVM must use more operations in order to reduce the size of the element from 32 bytes to the desired size.)

## GAS-17: ++i costs less gas than i++, especially when It's used in for-loops.(--i/i-- too)
<!--GAS-17 Tip -->

## GAS-18: array[index] += amount is cheaper than array[index] = array[index] + amount (or related variants)
<!--GAS-18 Tip -->

## GAS-19: Calling internal functions is cheaper
<!--GAS-19 Tip -->
- Description: Calling public functions is more expensive than calling internal functions, because in the former case all the parameters are copied into Memory. Whenever possible, prefer internal function calls, where the parameters are passed as references.

## GAS-20: uint\*(8/16/32..) vs uint256
<!--GAS-20 Tip -->
- Description: TheEVM run on 256 bits at a time thus using a unit\* it will firs be converted to unt256 and it cost extra gas) The EVM run on 256 bits at a time, thus using an uint\* (unsigned integers smaller than 256 bits), it will first be converted to uint256 and it costs extra gas. Use unsigned integers smaller or equal than 128 bits when packing more variables in one slot (see Variables Packing pattern). If not, it is better to use uint256 variables.
     
## GAS-21: Avoid contract existence checks by using version 0.8.10 or Later
<!--GAS-21 Tip -->
- Description: Prior to 0.8.10 the compiler inserted extra code, including EXTCODESIZE (700 gas), to check for contract existence for external calls. In more recent solidity versions, the compiler will not insert these checks if the external call has a return value)

## GAS-22: Using ``boolean` for storage incurs overhead
<!--GAS-22 Tip -->
- Description: Booleans are more expensive than uint256 or any type that takes up a full // word because each write operation emits an extra SLOAD to first read the // slot's contents, replace the bits taken up by the boolean, and then write // back. This is the compiler's defense against contract upgrades and // pointer aliasing, and it cannot be disabled.) (Use uint256(1) and uint256(2) for true/false to avoid a Gwarmaccess (100 gas) for the extra SLOAD, and to avoid Gsset (20000 gas) when changing from 'false' to 'true', after having been 'true' in the past) [source](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/58f635312aa21f947cae5f8578638a85aa2519f5/contracts/security/ReentrancyGuard.sol#L23-L27) 
## GAS-23: The increment in for loop post condition can be made unchecked
<!--GAS-23 Tip -->
- Description: (This is only relevant if you are using the default solidity checked arithmetic.) Consider the following generic for loop:

```solidity
   for (uint i = 0; i &lt; 100; i++) {
      // do something that doesn't change the value of i;
    };
```
- In this example, the for loop post condition, i.e., i++ involves checked arithmetic, which is not required. This is because the value of i is always strictly less than length <= 2\**256 - 1. Therefore, the theoretical maximum value of i to enter the for-loop body is 2**256 - 2. This means that the i++ in the for loop can never overflow. Regardless, the overflow checks are performed by the compiler. Unfortunately, the Solidity optimizer is not smart enough to detect this and remove the checks. One can manually do this by:

```solidity
      for (uint i = 0; i &lt; 100; unchecked(i++)) {;
        // do something that doesn't change the value of i
      };
```
```solidity
    function unchecked_increment(uint i) public pure returns (uint) {;
      unchecked {;
        return i++;
      };
```
- Note that it's important that the call to unchecked_inc is inlined. This is only possible for solidity versions starting from 0.8.2. Gas savings: roughly speaking this can save 30-40 gas per loop iteration. For lengthy loops, this can be significant!
## GAS-24: external functions are cheaper than public:
<!--GAS-24 Tip -->
- Description: The input parameters of public functions are copied to memory automatically, and this costs gas. The input parameters of external functions are read right from Calldata memory. Therefore, explicitly mark as external functions called only externally
## GAS-25: Mapping vs Array
<!--GAS-25 Tip -->
- Description: Solidity provides only two data types to represents list of data: arrays and maps. Mappings are cheaper, while arrays are packable and iterable In order to save gas, it is recommended to use mappings to manage lists of data, unless there is a need to iterate or it is possible to pack data types. This is useful both for Storage and Memory. You can manage an ordered list with a mapping using an integer index as a key

## GAS-26: Avoid redundant operations
<!--GAS-26 Tip -->
- Description: Avoid redundant operations. For instance, avoid double checks; the use of SafeMath library prevents underflow and overflow, so there is no need to check for them.
## GAS-27: Freeing storage
<!--GAS-27 Tip -->
- Description: To help keeping the size of the blockchain smaller, you get a gas refund every time you free the Storage. Therefore, it is convenient to delete the variables on the Storage, using the keyword delete, as soon as they are no longer necessary.

## GAS-28: Use assembly to check for address(0)
<!--GAS-28 Tip -->
## GAS-29 Use != 0 instead of > 0 for unsigned integer comparison	
<!--GAS-29 Tip -->
// first find map = h[2]
mapLoc = arrLocation(9, 2, 1);  // h is at slot 9

// then find map[456]
itemLoc = mapLocation(mapLoc, 456);
## References 
<!--References:  -->
- https://gist.github.com/hrkrshnn/ee8fabd532058307229d65dcd5836ddc
- https://forum.openzeppelin.com/t/a-collection-of-gas-optimisation-tricks/19966
