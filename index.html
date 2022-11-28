<h2>Introduction: Gas Optimization by example:</h2>

<figure>
  <img src="./assets/pyramid-of-learning.png" alt="learning pyramid" />
  <figcaption>
    Adapted from
    <cite
      ><a href="https://en.wikipedia.org/wiki/Learning_pyramid"
        >wikipedia</a
      ></cite
    >
  </figcaption>
</figure>

<figure>
  <blockquote>
    <p>
      Practice by doing, a form of "Discover Learning", is one of the most
      effective methods of learning and study. This method of study encourages
      students to take what they learn and put it into practice whereby
      promoting deeper understanding and moving information from short-term to
      long-term memory. Practice by doing makes material more personal, and thus
      more meaningful to students. Practice by doing also leads to more in-depth
      understanding of material, greater retention and better recall.
    </p>
  </blockquote>
  <figcaption>
    Adapted from
    <cite
      ><a href="https://www.educationcorner.com/the-learning-pyramid.html"
        >Education corner</a
      ></cite
    >
  </figcaption>
</figure>
<p>
  The best way to get the most out of this material is to fork the repo and try
  to disprove or prove that indeed a gas optimization tip works. Issue a pull
  request to improve the article
</p>

<div>
  <b> Table of content</b>
  <!-- TODO: Add a table of content  -->
</div>

<div>
  <h2>Installation</h2>
  <h3>SetUp:</h3>
  <p>
    You will need a copy of
    <a href="https://github.com/foundry-rs/foundry">Foundry</a> installed before
    proceeding. See the
    <a href="https://github.com/foundry-rs/foundry#installation"
      >Installation guide</a
    >
  </p>
  <pre>
   <code>
    git clone https://github.com/seanemile/gas-optimization
    cd gas-optimization
    forge install
   </code>
  </pre>
  <h3>Run Tests</h3>
  <pre>
    All the tests
    <code>
      forge test
    </code>
    Match a specific test
    <code>
      forge test --match-contract ContractName.sol>
    </code>
  </pre>
  <h3>Update Gas Snapshots</h3>
  <pre>
    <code>
      forge snapshot
    </code>
  </pre>
</div>

<div>
  <h2 id="GAS-1">
    GAS-1: Use smaller types than uint256 and Pack your variables!
  </h2>

  <p>
    Description: You don't need 256 bits to represent a timestamp, 32 bits are
    enough. Remember to use SafeCast to avoid overflow when casting
  </p>
  <p>
    Example:
    <a
      href="https://github.com/seanemile/gas-optimization/blob/main/src/Tip1.sol"
      >Tip.sol</a
    >
  </p>
  <pre>
  <code>
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
         timestamp = value.toUint32(); }
         }
  </code>
</pre>
</div>
<hr />

<div>
  <h2>GAS-2: Cache frequently used Storage variable, Mapping Structs</h2>

  - Description: Caching a mapping’s value in a local storage variable when the
  value is accessed multiple times, saves ~42 gas per access due to not having
  to recalculate the key’s keccak256 hash (Gkeccak256 - 30 gas) and that
  calculation’s associated stack operations. Caching an array’s struct avoids
  recalculating the array offsets into memory) - Example: So, instead of foo1()
  use foo2():
  [Tip2.sol](https://github.com/seanemile/gas-optimization/blob/main/src/Tip2.sol)
  ```solidity // SPDX-License-Identifier: MIT pragma solidity 0.8.17; contract
  Tip2 { uint256 public variable1 = 5; mapping(uint256 => uint256) public
  variable2; function foo1(uint256 someNum) external { variable2[variable1] =
  someNum; } function foo2(uint256 someNum) external { uint256 tempBar =
  variable1; // tempBar is in memory and cheaper to read from
  variable2[variable1] = someNum; } } ``` ![Gas Usage](/assets/image1.png). ---
</div>

<div>
  <h2>GAS-3: Declare Constructor as payable.</h2>
  - Description: You eliminate the payable check. Saving gas during deployment.
  - Example:
  [Tip3a.sol](https://github.com/seanemile/gas-optimization/blob/main/src/Tip3a.sol)
  and
  [Tip3b.sol](https://github.com/seanemile/gas-optimization/blob/main/src/Tip3b.sol)
  ```solidity // SPDX-License-Identifier: MIT pragma solidity 0.8.17; contract
  Tip3a { uint256 public variable1; constructor() payable { variable1 = 5; } }
  ``` ```solidity // SPDX-License-Identifier: MIT pragma solidity 0.8.17;
  contract Tip3b { uint256 public variable1; constructor() { variable1 = 5; } }
  ``` ![Gas Usage](/assets/image2.png). ![Gas Usage](/assets/image3.png). ---
</div>
<div>
  <h2>GAS-4: Upgrade at least 0.8.4</h2>

  -Description: Using newer compiler versions and the optimizer gives gas
  optimizations and additional safety checks for free!
  <h3>Advantages of versions =0.8.\*= over =<0.8.0= are:</h3>

  - Safemath by default from =0.8.0= (can be more gas efficient than
  /some/library based safemath). -
  [[https://blog.soliditylang.org/2021/03/02/saving-gas-with-simple-inliner/][Low
  level inliner]] from =0.8.2=, leads to cheaper runtime gas. Especially
  relevant when the contract has small functions. For example, OpenZeppelin
  libraries typically have a lot of small helper functions and if they are not
  inlined, they cost an additional 20 to 40 gas because of 2 extra =jump=
  instructions and additional stack operations needed for function calls. -
  [[https://blog.soliditylang.org/2021/03/23/solidity-0.8.3-release-announcement/#optimizer-improvements][Optimizer
  improvements in packed structs]]: Before =0.8.3=, storing packed structs, in
  some cases used an additional storage read operation. After
  [[https://eips.ethereum.org/EIPS/eip-2929][EIP-2929]], if the slot was already
  cold, this means unnecessary stack operations and extra deploy time costs.
  However, if the slot was already warm, this means additional cost of =100= gas
  alongside the same unnecessary stack operations and extra deploy time costs. -
  [[https://blog.soliditylang.org/2021/04/21/custom-errors][Custom errors]] from
  =0.8.4=, leads to cheaper deploy time cost and run time cost. Note: the run
  time cost is only relevant when the revert condition is met. In short, replace
  revert strings by custom errors. ---
</div>

<div>
  <h2>GAS-5: Caching the length in for loops:</h2>

  - Example: ```solidity // SPDX-License-Identifier: UNLICENSED pragma solidity
  ^0.8.13; contract Array { uint256[10] public number; ///@notice Looping over a
  storage array: Without cache function loop1() public view { for (uint256 i; i
  < number.length;) { ++i; } } ///@notice Looping over a storage array with
  cached length outside of the loop function loop2() public view { uint256
  length = number.length; for (uint256 i; i < length;) { ++i; } } ///@notice
  Looping over a memory array without cached length function loop3() public pure
  { uint256[] memory num1 = new uint256[](10); for (uint256 i; i < num1.length;)
  { ++i; } } ///@notice Looping over a memory array with cached length outside
  of the loop function loop4() public pure { uint256[] memory num1 = new
  uint256[](10); uint256 length = num1.length; for (uint256 i; i < length;) {
  ++i; } } } ``` via_ir=false optimization=200
  <br />
  ![Gas Usage](/assets/image4.png) via_ir=false optimization=1000
  <br />
  ![Gas Usage](/assets/image5.png) via_ir=true optimization=200
  <br />
  ![Gas Usage](/assets/image6.png) via_ir=true optimization=1000
  <br />
  ![Gas Usage](/assets/image7.png) ---
</div>

<div>
  <h2>
    GAS-6: Use calldata instead of memory for function arguments that don't get
    mutated
  </h2>

  Gas savings: In the former example, the ABI decoding begins with copying value
  from calldata to memory in a for loop. Each iteration would cost at least 60
  gas. In the latter example, this can be completely avoided. This will also
  reduce the number of instructions and therefore reduces the deploy time cost
  of the contract. ```solidity // SPDX-License-Identifier: MIT pragma solidity
  0.8.17; contract Tip6 { function add1(uint256[] memory arr) external pure
  returns (uint256 sum) { uint256 length = arr.length; for (uint256 i = 0; i <
  length; i++) { sum += arr[i]; } } function add2(uint256[] calldata arr)
  external pure returns (uint256 sum) { uint256 length = arr.length; for
  (uint256 i = 0; i < length; i++) { sum += arr[i]; } } } ``` via_ir=false
  optimization=200 ![Gas Usage](/assets/image9.png) via_ir=true optimization=200
  ![Gas Usage](/assets/image8.png) ---
</div>

<div>
  <h2>GAS-7: Use IR(yul) compiler pipeline</h2>

  Notice through the sample code the effects of turning on IR ---
</div>

<div>
  <h2>GAS-8: Consider using custom errors instead of revert strings.</h2>

  Solidity 0.8.4 introduced custom errors. They are more gas efficient than
  revert strings, when it comes to deploy cost as well as runtime cost when the
  revert condition is met. Use custom errors instead of revert strings for gas
  savings. ---
</div>

<div>
  <h2>GAS-9: Use immutable State variables where applicable</h2>

  Example, each call to the function owner1() reads from storage, using a sload.
  After EIP-2929, this costs 2100 gas cold or 100 gas warm. However owner2() is
  more gas efficient: ```solidity // SPDX-License-Identifier: MIT pragma
  solidity 0.8.17; contract Tip9 { /// The owner is set during construction
  time, and never changed afterwards. address public owner1 = msg.sender; ///
  The owner is set during construction time, and never changed afterwards.
  address public immutable owner2 = msg.sender; } ``` via_ir=true
  optimization=200 ![Gas Usage](/assets/image10.png) ---
</div>

<div>
  <h2>GAS-10: Use short revert strings.</h2>
</div>

---

<div>
  <h2>
    GAS-11: Use bytes32 rather string/bytes (fixed sizes are always cheaper).
  </h2>
</div>

---

<div>
  <h2>GAS-12: Function modifiers can be inefficient</h2>

  The code of modifiers is inlined inside the modified function, thus adding up
  size and costing gas. Limit the modifiers. Internal functions are not inlined,
  but called as separate functions. They are slightly more expensive at run
  time, but save a lot of redundant bytecode in deployment, if used more than
  once ---
</div>

<div>
  <h2>GAS-13: No need to initialize variables with default values</h2>

  In Solidity, all variables are set to zeroes by default. So, do not explicitly
  initialize a variable with its default value if it is zero. ---
</div>

<div>
  <h2>GAS-14: Avoid repetitive checks eg using safe math library</h2>

  ---

  <div>
    <h2>
      GAS-15: Using `private` visibility rather than `public` for constants
    </h2>

    - Description If needed, the value can be read from the verified contract
    source code. Savings are due to the compiler not having to create
    non-payable getter functions for deployment calldata, and not adding another
    entry to the method ID table) ---
  </div>

  <div>
    <h2>
      GAS-16: Usage of UINT/INTS smaller than 32 bytes (256 bits) incurs
      overhead
    </h2>

    When using elements that are smaller than 32 bytes, your contract’s gas
    usage may be higher. This is because the EVM operates on 32 bytes at a time.
    Therefore, if the element is smaller than that, the EVM must use more
    operations in order to reduce the size of the element from 32 bytes to the
    desired size.) ---
  </div>

  <div>
    <h2>
      GAS-17: ++I costs less gas than I++, especially when It's used in
      for-loops
    </h2>
  </div>

  ---

  <div>
    <h2>GAS-18.</h2>
  </div>

  ---

  <div>
    <h2>GAS-19: Calling internal functions is cheaper</h2>

    Calling public functions is more expensive than calling internal functions,
    because in the former case all the parameters are copied into Memory.
    Whenever possible, prefer internal function calls, where the parameters are
    passed as references. ---
  </div>

  <div>
    <h2>GAS-20: uint\*(8/16/32..) vs uint256</h2>

    TheEVM run on 256 bits at a time thus using a unit\* it will firs be
    converted to unt256 and it cost extra gas) The EVM run on 256 bits at a
    time, thus using an uint\* (unsigned integers smaller than 256 bits), it
    will first be converted to uint256 and it costs extra gas. Use unsigned
    integers smaller or equal than 128 bits when packing more variables in one
    slot (see Variables Packing pattern). If not, it is better to use uint256
    variables. ---
  </div>
  <div>
    <h2>
      GAS-21: AVOID CONTRACT EXISTENCE CHECKS BY USING SOLIDITY VERSION 0.8.10
      OR LATER
    </h2>

    Prior to 0.8.10 the compiler inserted extra code, including EXTCODESIZE (700
    gas), to check for contract existence for external calls. In more recent
    solidity versions, the compiler will not insert these checks if the external
    call has a return value) ---
  </div>

  <div>
    <h2>GAS-22: Using ``boolean` for storage incurs overhead</h2>

    Booleans are more expensive than uint256 or any type that takes up a full //
    word because each write operation emits an extra SLOAD to first read the //
    slot's contents, replace the bits taken up by the boolean, and then write //
    back. This is the compiler's defense against contract upgrades and //
    pointer aliasing, and it cannot be disabled.) (Use uint256(1) and uint256(2)
    for true/false to avoid a Gwarmaccess (100 gas) for the extra SLOAD, and to
    avoid Gsset (20000 gas) when changing from ‘false’ to ‘true’, after having
    been ‘true’ in the past) ---
  </div>

  <div>
    <h2>
      GAS-23: The increment in for loop post condition can be made unchecked
    </h2>

    (This is only relevant if you are using the default solidity checked
    arithmetic.) Consider the following generic for loop: for (uint i = 0; i <
    length; i++) { // do something that doesn't change the value of i } In this
    example, the for loop post condition, i.e., i++ involves checked arithmetic,
    which is not required. This is because the value of i is always strictly
    less than length <= 2**256 - 1. Therefore, the theoretical maximum value of
    i to enter the for-loop body is 2**256 - 2. This means that the i++ in the
    for loop can never overflow. Regardless, the overflow checks are performed
    by the compiler. Unfortunately, the Solidity optimizer is not smart enough
    to detect this and remove the checks. One can manually do this by: for (uint
    i = 0; i < length; i = unchecked_inc(i)) { // do something that doesn't
    change the value of i } function unchecked_inc(uint i) returns (uint) {
    unchecked { return i + 1; } } Note that it’s important that the call to
    unchecked_inc is inlined. This is only possible for solidity versions
    starting from 0.8.2. Gas savings: roughly speaking this can save 30-40 gas
    per loop iteration. For lengthy loops, this can be significant! ---
  </div>

  <div>
    <h2>GAS-24: external functions are cheaper than public:</h2>

    <p>
      The input parameters of public functions are copied to memory
      automatically, and this costs gas. The input parameters of external
      functions are read right from Calldata memory. Therefore, explicitly mark
      as external functions called only externally
    </p>
  </div>

  <div>
    <h2>GAS-25: Mapping vs Array</h2>

    <p>
      Solidity provides only two data types to represents list of data: arrays
      and maps. Mappings are cheaper, while arrays are packable and iterable In
      order to save gas, it is recommended to use mappings to manage lists of
      data, unless there is a need to iterate or it is possible to pack data
      types. This is useful both for Storage and Memory. You can manage an
      ordered list with a mapping using an integer index as a key
    </p>
  </div>

  <div>
    <h2>GAS-26: Avoid redundant operations</h2>

    <p>
      Avoid redundant operations. For instance, avoid double checks; the use of
      SafeMath library prevents underflow and overflow, so there is no need to
      check for them.
    </p>
  </div>
  <div>
    <h2>GAS-27: Freeing storage</h2>

    <p>
      To help keeping the size of the blockchain smaller, you get a gas refund
      every time you free the Storage. Therefore, it is convenient to delete the
      variables on the Storage, using the keyword delete, as soon as they are no
      longer necessary.
    </p>

    <div>
      <h2>GAS-28: Use assembly to check for address(0)</h2>
    </div>

    <div>
      <h2>References:</h2>

      <ol>
        <li>
          https://gist.github.com/hrkrshnn/ee8fabd532058307229d65dcd5836ddc
        </li>
        <li>
          https://forum.openzeppelin.com/t/a-collection-of-gas-optimisation-tricks/19966
        </li>
      </ol>
    </div>

    ---
  </div>
</div>
