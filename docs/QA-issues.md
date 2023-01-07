Table of content
- [M-1: Integer Overflow and Underflow](#m-1-integer-overflow-and-underflow)
- [M-2: Outdated Compiler Version](#m-2-outdated-compiler-version)
- [M-3: Floating Pragma](#m-3-floating-pragma)
- [M-4: Unchecked Call Return Value,](#m-4-unchecked-call-return-value)
- [M-5: Unprotected Ether Withdrawal,](#m-5-unprotected-ether-withdrawal)
- [M-6: Unprotected SELFDESTRUCT Instruction,](#m-6-unprotected-selfdestruct-instruction)
- [M-7: Reentrancy,](#m-7-reentrancy)
- [M-8: State Variable Default Visibility,](#m-8-state-variable-default-visibility)
- [M-9: Uninitialized Storage Pointer,](#m-9-uninitialized-storage-pointer)
- [M-10: Assert Violation,](#m-10-assert-violation)
- [M-11: Use of Deprecated Solidity Functions,](#m-11-use-of-deprecated-solidity-functions)
- [M-12: Delegatecall to Untrusted Callee,](#m-12-delegatecall-to-untrusted-callee)
- [M-13 Title: DoS with Failed Call,](#m-13-title-dos-with-failed-call)
- [M-14: Transaction Order Dependence,](#m-14-transaction-order-dependence)
- [M-15: Authorization through tx.origin,](#m-15-authorization-through-txorigin)
- [M-16: Block values as a proxy for time,](#m-16-block-values-as-a-proxy-for-time)
- [M-17: Signature Malleability,](#m-17-signature-malleability)
- [M-18: Incorrect Constructor Name,](#m-18-incorrect-constructor-name)
- [M-19: Shadowing State Variables,](#m-19-shadowing-state-variables)
- [M-20: Weak Sources of Randomness from Chain Attributes,](#m-20-weak-sources-of-randomness-from-chain-attributes)
- [M-21: Missing Protection against Signature Replay Attacks,](#m-21-missing-protection-against-signature-replay-attacks)
- [M-22: Lack of Proper Signature Verification,](#m-22-lack-of-proper-signature-verification)
- [M-23: Requirement Violation,](#m-23-requirement-violation)
- [M-24: Write to Arbitrary Storage Location,](#m-24-write-to-arbitrary-storage-location)
- [M-25: Incorrect Inheritance Order,](#m-25-incorrect-inheritance-order)
- [M-26: Insufficient Gas Griefing,](#m-26-insufficient-gas-griefing)
- [M-27: Arbitrary Jump with Function Type Variable,](#m-27-arbitrary-jump-with-function-type-variable)
- [M-28: DoS With Block Gas Limit,](#m-28-dos-with-block-gas-limit)
- [M-29: Typographical Error,](#m-29-typographical-error)
- [M-30: Right-To-Left-Override control character (U+202E),](#m-30-right-to-left-override-control-character-u202e)
- [M-31: Presence of unused variables,](#m-31-presence-of-unused-variables)
- [M-32: Unexpected Ether balance,](#m-32-unexpected-ether-balance)
- [M-33: Hash Collisions With Multiple Variable Length Arguments,](#m-33-hash-collisions-with-multiple-variable-length-arguments)
- [M-34: Message call with hardcoded gas amount,](#m-34-message-call-with-hardcoded-gas-amount)
- [M-35:Code With No Effects,](#m-35code-with-no-effects)
- [M-36: Unencrypted Private Data On-Chain,](#m-36-unencrypted-private-data-on-chain)
- [M-37: require() / revert() statements should have descriptive reason strings](#m-37-require--revert-statements-should-have-descriptive-reason-strings)
- [M-38: Event is missing indexed fields](#m-38-event-is-missing-indexed-fields)
- [M-39: Constants should be defined rather than using magic numbers](#m-39-constants-should-be-defined-rather-than-using-magic-numbers)
- [M-40: Functions not used internally could be marked external](#m-40-functions-not-used-internally-could-be-marked-external)
- [M-41: Return values of approve() not checked](#m-41-return-values-of-approve-not-checked)
- [M-42 bi.encodePacked() should not be used with dynamic types when passing the result to a hash function such as keccak256()](#m-42-biencodepacked-should-not-be-used-with-dynamic-types-when-passing-the-result-to-a-hash-function-such-as-keccak256)
- [M-43 Unspecified compiler version](#m-43-unspecified-compiler-version)
- [M-44 Unsafe ERC20 operation(s)](#m-44-unsafe-erc20-operations)
- [M-45 Centralization Risk for trusted owners](#m-45-centralization-risk-for-trusted-owners)


## M-1: Integer Overflow and Underflow
- Description: An overflow/underflow happens when an arithmetic operation reaches the maximum or minimum size of a type. For instance if a number is stored in the uint8 type, it means that the number is stored in a 8 bits unsigned number ranging from 0 to 2^8-1. In computer programming, an integer overflow occurs when an arithmetic operation attempts to create a numeric value that is outside of the range that can be represented with a given number of bits – either larger than the maximum or lower than the minimum representable value.
- Remediation: It is recommended to use vetted safe math libraries for arithmetic operations consistently throughout the smart contract system.

## M-2: Outdated Compiler Version
- Description: Using an outdated compiler version can be problematic especially if there are publicly disclosed bugs and issues that affect the current compiler version.
- Remediation: It is recommended to use a recent version of the Solidity compiler.

## M-3: Floating Pragma
- Description: Contracts should be deployed with the same compiler version and flags that they have been tested with thoroughly. Locking the pragma helps to ensure that contracts do not accidentally get deployed using, for example, an outdated compiler version that might introduce bugs that affect the contract system negatively.,
- Remediation: Lock the pragma version and also consider known bugs (https://github.com/ethereum/solidity/releases) for the compiler version that is chosen. \n\n\nPragma statements can be allowed to float when a contract is intended for consumption by other developers, as in the case with contracts in a library or EthPM package. Otherwise, the developer would need to manually update the pragma in order to compile locally.

## M-4: Unchecked Call Return Value,
- Description: The return value of a message call is not checked. Execution will resume even if the called contract throws an exception. If the call fails accidentally or an attacker forces the call to fail, this may cause unexpected behaviour in the subsequent program logic.,
- Remediation: If you choose to use low-level call methods, make sure to handle the possibility that the call will fail by checking the return value.

## M-5: Unprotected Ether Withdrawal,
- Description: Due to missing or insufficient access controls, malicious parties can withdraw some or all Ether from the contract account.\n\n\nThis bug is sometimes caused by unintentionally exposing initialization functions. By wrongly naming a function intended to be a constructor, the constructor code ends up in the runtime byte code and can be called by anyone to re-initialize the contract.,
- Remediation: Implement controls so withdrawals can only be triggered by authorized parties or according to the specs of the smart contract system.

## M-6: Unprotected SELFDESTRUCT Instruction,
- Description: Due to missing or insufficient access controls, malicious parties can self-destruct the contract.,
- Remediation: Consider removing the self-destruct functionality unless it is absolutely required. If there is a valid use-case, it is recommended to implement a multisig scheme so that multiple parties must approve the self-destruct action.

## M-7: Reentrancy,
- Description: One of the major dangers of calling external contracts is that they can take over the control flow. In the reentrancy attack (a.k.a. recursive call attack), a malicious contract calls back into the calling contract before the first invocation of the function is finished. This may cause the different invocations of the function to interact in undesirable ways.,
- Remediation: The best practices to avoid Reentrancy weaknesses are: \n\n\n- Make sure all internal state changes are performed before the call is executed. This is known as the [Checks-Effects-Interactions pattern](https://solidity.readthedocs.io/en/latest/security-considerations.html#use-the-checks-effects-interactions-pattern)\n- Use a reentrancy lock (ie.  [OpenZeppelin's ReentrancyGuard](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ReentrancyGuard.sol).

## M-8: State Variable Default Visibility,
- Description: Labeling the visibility explicitly makes it easier to catch incorrect assumptions about who can access the variable.,
- Remediation: Variables can be specified as being `public`, `internal` or `private`. Explicitly define visibility for all state variables.

## M-9: Uninitialized Storage Pointer,
- Description: Uninitialized local storage variables can point to unexpected storage locations in the contract, which can lead to intentional or unintentional vulnerabilities.,
-Remediation: Check if the contract requires a storage object as in many situations this is actually not the case. If a local variable is sufficient, mark the storage location of the variable explicitly with the `memory` attribute. If a storage variable is needed then initialise it upon declaration and additionally specify the storage location `storage`.\n\n\n**Note**: As of compiler version 0.5.0 and higher this issue has been systematically resolved as contracts with uninitialised storage pointers do no longer compile.

## M-10: Assert Violation,
- Description: The Solidity `assert()` function is meant to assert invariants. Properly functioning code should *never* reach a failing assert statement. A reachable assertion can mean one of two things:\n\n\n1. A bug exists in the contract that allows it to enter an invalid state;\n1. The `assert` statement is used incorrectly, e.g. to validate inputs.,
- Remediation: Consider whether the condition checked in the `assert()` is actually an invariant. If not, replace the `assert()` statement with a `require()` statement.\n\n\nIf the exception is indeed caused by unexpected behaviour of the code, fix the underlying bug(s) that allow the assertion to be violated.

## M-11: Use of Deprecated Solidity Functions,
- Description: Several functions and operators in Solidity are deprecated. Using them leads to reduced code quality. With new major versions of the Solidity compiler, deprecated functions and operators may result in side effects and compile errors.,
- Remediation: Solidity provides alternatives to the deprecated constructions. Most of them are aliases, thus replacing old constructions will not break current behavior. For example, `sha3` can be replaced with `keccak256`.\n\n\n| Deprecated | Alternative | \n|: ---------:| ---------:| \n| `suicide(address)` | `selfdestruct(address)` | \n| `block.blockhash(uint)` | `blockhash(uint)` | \n| `sha3(...)` | `keccak256(...)` | \n| `callcode(...)` | `delegatecall(...)` | \n| `throw` | `revert()` | \n| `msg.gas` | `gasleft` | \n| `constant` | `view` | \n| `var` | corresponding type name |

## M-12: Delegatecall to Untrusted Callee,
- Description: There exists a special variant of a message call, named `delegatecall` which is identical to a message call apart from the fact that the code at the target address is executed in the context of the calling contract and `msg.sender` and `msg.value` do not change their values. This allows a smart contract to dynamically load code from a different address at runtime. Storage, current address and balance still refer to the calling contract.\n\n\nCalling into untrusted contracts is very dangerous, as the code at the target address can change any storage values of the caller and has full control over the caller's balance.,
- Remediation: Use `delegatecall` with caution and make sure to never call into untrusted contracts. If the target address is derived from user input ensure to check it against a whitelist of trusted contracts.

## M-13 Title: DoS with Failed Call,
- Description: External calls can fail accidentally or deliberately, which can cause a DoS condition in the contract. To minimize the damage caused by such failures, it is better to isolate each external call into its own transaction that can be initiated by the recipient of the call. This is especially relevant for payments, where it is better to let users withdraw funds rather than push funds to them automatically (this also reduces the chance of problems with the gas limit).,
- Remediation: It is recommended to follow call best practices:\n\n\n- Avoid combining multiple calls in a single transaction, especially when calls are executed as part of a loop\n- Always assume that external calls can fail\n- Implement the contract logic to handle failed calls

## M-14: Transaction Order Dependence,
- Description: The Ethereum network processes transactions in blocks with new blocks getting confirmed around every 17 seconds. The miners look at transactions they have received and select which transactions to include in a block, based who has paid a high enough gas price to be included. Additionally, when transactions are sent to the Ethereum network they are forwarded to each node for processing. Thus, a person who is running an Ethereum node can tell which transactions are going to occur before they are finalized.A race condition vulnerability occurs when code depends on the order of the transactions submitted to it.\n\n\nThe simplest example of a race condition is when a smart contract give a reward for submitting information. Say a contract will give out 1 token to the first person who solves a math problem. Alice solves the problem and submits the answer to the network with a standard gas price. Eve runs an Ethereum node and can see the answer to the math problem in the transaction that Alice submitted to the network. So Eve submits the answer to the network with a much higher gas price and thus it gets processed and committed before Alice's transaction. Eve receives one token and Alice gets nothing, even though it was Alice who worked to solve the problem. A common way this occurs in practice is when a contract rewards people for calling out bad behavior in a protocol by giving a bad actor's deposit to the person who proved they were misbehaving.\n\n\nThe race condition that happens the most on the network today is the race condition in the ERC20 token standard. The ERC20 token standard includes a function called 'approve' which allows an address to approve another address to spend tokens on their behalf. Assume that Alice has approved Eve to spend n of her tokens, then Alice decides to change Eve's approval to m tokens. Alice submits a function call to approve with the value n for Eve. Eve runs a Ethereum node so knows that Alice is going to change her approval to m. Eve then submits a tranferFrom request sending n of Alice's tokens to herself, but gives it a much higher gas price than Alice's transaction. The transferFrom executes first so gives Eve n tokens and sets Eve's approval to zero. Then Alice's transaction executes and sets Eve's approval to m. Eve then sends those m tokens to herself as well. Thus Eve gets n + m tokens even thought she should have gotten at most max(n,m).,
- Remediation: A possible way to remedy for race conditions in submission of information in exchange for a reward is called a commit reveal hash scheme. Instead of submitting the answer the party who has the answer submits hash(salt, address, answer) [salt being some number of their choosing] the contract stores this hash and the sender's address. To claim the reward the sender then submits a transaction with the salt, and answer. The contract hashes (salt, msg.sender, answer) and checks the hash produced against the stored hash, if the hash matches the contract releases the reward.\n\n\nThe best fix for the ERC20 race condition is to add a field to the inputs of approve which is the expected current value and to have approve revert if Eve's current allowance is not what Alice indicated she was expecting. However this means that your contract no longer conforms to the ERC20 standard. If it important to your project to have the contract conform to ERC20, you can add a safe approve function. From the user perspective it is possible to mediate the ERC20 race condition by setting approvals to zero before changing them.

## M-15: Authorization through tx.origin,
- Description: `tx.origin` is a global variable in Solidity which returns the address of the account that sent the transaction. Using the variable for authorization could make a contract vulnerable if an authorized account calls into a malicious contract. A call could be made to the vulnerable contract that passes the authorization check since `tx.origin` returns the original sender of the transaction which in this case is the authorized account.,
- Remediation: `tx.origin` should not be used for authorization. Use `msg.sender` instead.

## M-16: Block values as a proxy for time,
- Description: Contracts often need access to time values to perform certain types of functionality. Values such as `block.timestamp`, and `block.number` can give you a sense of the current time or a time delta, however, they are not safe to use for most purposes.\n\n\nIn the case of `block.timestamp`, developers often attempt to use it to trigger time-dependent events. As Ethereum is decentralized, nodes can synchronize time only to some degree. Moreover, malicious miners can alter the timestamp of their blocks, especially if they can gain advantages by doing so. However, miners can't set a timestamp smaller than the previous one (otherwise the block will be rejected), nor can they set the timestamp too far ahead in the future. Taking all of the above into consideration, developers can't rely on the preciseness of the provided timestamp.\n\n\nAs for `block.number`, considering the block time on Ethereum is generally about 14 seconds, it's possible to predict the time delta between blocks. However, block times are not constant and are subject to change for a variety of reasons, e.g. fork reorganisations and the difficulty bomb. Due to variable block times, `block.number` should also not be relied on for precise calculations of time.,
- Remediation: Developers should write smart contracts with the notion that block values are not precise, and the use of them can lead to unexpected effects. Alternatively, they may make use oracles.

## M-17: Signature Malleability,
- Description: The implementation of a cryptographic signature system in Ethereum contracts often assumes that the signature is unique, but signatures can be altered without the possession of the private key and still be valid. The EVM specification defines several so-called ‘precompiled’ contracts one of them being `ecrecover` which executes the elliptic curve public key recovery. A malicious user can slightly modify the three values _v_, _r_ and _s_ to create other valid signatures. A system that performs signature verification on contract level might be susceptible to attacks if the signature is part of the signed message hash. Valid signatures could be created by a malicious user to replay previously signed messages.,
- Remediation: A signature should never be included into a signed message hash to check if previously messages have been processed by the contract.

## M-18: Incorrect Constructor Name,
- Description: Constructors are special functions that are called only once during the contract creation. They often perform critical, privileged actions such as setting the owner of the contract. Before Solidity version 0.4.22, the only way of defining a constructor was to create a function with the same name as the contract class containing it. A function meant to become a constructor becomes a normal, callable function if its name doesn't exactly match the contract name.\nThis behavior sometimes leads to security issues, in particular when smart contract code is re-used with a different name but the name of the constructor function is not changed accordingly.,
- Remediation: Solidity version 0.4.22 introduces a new `constructor` keyword that make a constructor definitions clearer. It is therefore recommended to upgrade the contract to a recent version of the Solidity compiler and change to the new constructor declaration.

## M-19: Shadowing State Variables,
- Description: Solidity allows for ambiguous naming of state variables when inheritance is used. Contract `A` with a variable `x` could inherit contract `B` that also has a state variable `x` defined. This would result in two separate versions of `x`, one of them being accessed from contract `A` and the other one from contract `B`. In more complex contract systems this condition could go unnoticed and subsequently lead to security issues. \n\n\nShadowing state variables can also occur within a single contract when there are multiple definitions on the contract and function level.,
- Remediation: Review storage variable layouts for your contract systems carefully and remove any ambiguities. Always check for compiler warnings as they can flag the issue within a single contract.

## M-20: Weak Sources of Randomness from Chain Attributes,
- Description: Ability to generate random numbers is very helpful in all kinds of applications. One obvious example is gambling DApps, where pseudo-random number generator is used to pick the winner. However, creating a strong enough source of randomness in Ethereum is very challenging. For example, use of `block.timestamp` is insecure, as a miner can choose to provide any timestamp within a few seconds and still get his block accepted by others. Use of `blockhash`, `block.difficulty` and other fields is also insecure, as they're controlled by the miner. If the stakes are high, the miner can mine lots of blocks in a short time by renting hardware, pick the block that has required block hash for him to win, and drop all others.,
- Remediation: - Using [commitment scheme](https://en.wikipedia.org/wiki/Commitment_scheme), e.g. [RANDAO](https://github.com/randao/randao).\n- Using external sources of randomness via oracles, e.g. [Oraclize](http://www.oraclize.it/). Note that this approach requires trusting in oracle, thus it may be reasonable to use multiple oracles.\n- Using Bitcoin block hashes, as they are more expensive to mine

## M-21: Missing Protection against Signature Replay Attacks,
- Description: It is sometimes necessary to perform signature verification in smart contracts to achieve better usability or to save gas cost. A secure implementation needs to protect against Signature Replay Attacks by for example keeping track of all processed message hashes and only allowing new message hashes to be processed. A malicious user could attack a contract without such a control and get message hash that was sent by another user processed multiple times.,
- Remediation: In order to protect against signature replay attacks consider the following recommendations:\n\n\n- Store every message hash that has been processed by the smart contract. When new messages are received check against the already existing ones and only proceed with the business logic if it's a new message hash. \n- Include the address of the contract that processes the message. This ensures that the message can only be used in a single contract. \n- Under no circumstances generate the message hash including the signature. The `ecrecover` function is susceptible to signature malleability (see also SWC-117).

## M-22: Lack of Proper Signature Verification,
- Description: It is a common pattern for smart contract systems to allow users to sign messages off-chain instead of directly requesting users to do an on-chain transaction because of the flexibility and increased transferability that this provides. Smart contract systems that process signed messages have to implement their own logic to recover the authenticity from the signed messages before they process them further. A limitation for such systems is that smart contracts can not directly interact with them because they can not sign messages. Some signature verification implementations attempt to solve this problem by assuming the validity of a signed message based on other methods that do not have this limitation. An example of such a method is to rely on `msg.sender` and assume that if a signed message originated from the sender address then it has also been created by the sender address. This can lead to vulnerabilities especially in scenarios where proxies can be used to relay transactions.,
- Remediation: It is not recommended to use alternate verification schemes that do not require proper signature verification through `ecrecover()`.

## M-23: Requirement Violation,
- Description: The Solidity `require()` construct is meant to validate external inputs of a function. In most cases, such external inputs are provided by callers, but they may also be returned by callees. In the former case, we refer to them as precondition violations. Violations of a requirement can indicate one of two possible issues:\n\n\n1. A bug exists in the contract that provided the external input.\n1. The condition used to express the requirement is too strong.,
- Remediation: If the required logical condition is too strong, it should be weakened to allow all valid external inputs.\n\n\nOtherwise, the bug must be in the contract that provided the external input and one should consider fixing its code by making sure no invalid inputs are provided.

## M-24: Write to Arbitrary Storage Location,
- Description: A smart contract's data (e.g., storing the owner of the contract) is persistently stored\nat some storage location (i.e., a key or address) on the EVM level. The contract is\nresponsible for ensuring that only authorized user or contract accounts may write to\nsensitive storage locations. If an attacker is able to write to arbitrary storage\nlocations of a contract, the authorization checks may easily be circumvented. This can\nallow an attacker to corrupt the storage; for instance, by overwriting a field that stores\nthe address of the contract owner.,
- Remediation: As a general advice, given that all data structures share the same storage (address)\nspace, one should make sure that writes to one data structure cannot inadvertently\noverwrite entries of another data structure.

## M-25: Incorrect Inheritance Order,
- Description: Solidity supports multiple inheritance, meaning that one contract can inherit several contracts. Multiple inheritance introduces ambiguity called [Diamond Problem](https://en.wikipedia.org/wiki/Multiple_inheritance#The_diamond_problem): if two or more base contracts define the same function, which one should be called in the child contract? Solidity deals with this ambiguity by using reverse [C3 Linearization](https://en.wikipedia.org/wiki/C3_linearization), which sets a priority between base contracts.\n\n\nThat way, base contracts have different priorities, so the order of inheritance matters. Neglecting inheritance order can lead to unexpected behavior.,
- Remediation: When inheriting multiple contracts, especially if they have identical functions, a developer should carefully specify inheritance in the correct order. The rule of thumb is to inherit contracts from more /general/ to more /specific/.

## M-26: Insufficient Gas Griefing,
- Description: Insufficient gas griefing attacks can be performed on contracts which accept data and use it in a sub-call on another contract. If the sub-call fails, either the whole transaction is reverted, or execution is continued. In the case of a relayer contract, the user who executes the transaction, the 'forwarder', can effectively censor transactions by using just enough gas to execute the transaction, but not enough for the sub-call to succeed.,
- Remediation: There are two options to prevent insufficient gas griefing:\n\n\n- Only allow trusted users to relay transactions.\n- Require that the forwarder provides enough gas.

## M-27: Arbitrary Jump with Function Type Variable,
- Description: Solidity supports function types. That is, a variable of function type can be assigned with a reference to a function with a matching signature. The function saved to such variable can be called just like a regular function.\n\n\nThe problem arises when a user has the ability to arbitrarily change the function type variable and thus execute random code instructions. As Solidity doesn't support pointer arithmetics, it's impossible to change such variable to an arbitrary value. However, if the developer uses assembly instructions, such as `mstore` or assign operator, in the worst case scenario an attacker is able to point a function type variable to any code instruction, violating required validations and required state changes.,
- Remediation: The use of assembly should be minimal. A developer should not allow a user to assign arbitrary values to function type variables.

## M-28: DoS With Block Gas Limit,
- Description: When smart contracts are deployed or functions inside them are called, the execution of these actions always requires a certain amount of gas, based of how much computation is needed to complete them. The Ethereum network specifies a block gas limit and the sum of all transactions included in a block can not exceed the threshold. \n\n\nProgramming patterns that are harmless in centralized applications can lead to Denial of Service conditions in smart contracts when the cost of executing a function exceeds the block gas limit. Modifying an array of unknown size, that increases in size over time, can lead to such a Denial of Service condition.,
- Remediation: Caution is advised when you expect to have large arrays that grow over time. Actions that require looping across the entire data structure should be avoided.  \n\n\nIf you absolutely must loop over an array of unknown size, then you should plan for it to potentially take multiple blocks, and therefore require multiple transactions.

## M-29: Typographical Error,
- Description: A typographical error can occur for example when the intent of a defined operation is to sum a number to a variable (+=) but it has accidentally been defined in a wrong way (=+), introducing a typo which happens to be a valid operator. Instead of calculating the sum it initializes the variable again. \n\n\nThe unary + operator is deprecated in new solidity compiler versions.,
- Remediation: The weakness can be avoided by performing pre-condition checks on any math operation or using a vetted library for arithmetic calculations such as SafeMath developed by OpenZeppelin.

## M-30: Right-To-Left-Override control character (U+202E),
- Description: Malicious actors can use the Right-To-Left-Override unicode character to force RTL text rendering and confuse users as to the real intent of a contract.,
- Remediation: There are very few legitimate uses of the U+202E character. It should not appear in the source code of a smart contract.

## M-31: Presence of unused variables,
- Description: Unused variables are allowed in Solidity and they do not pose a direct security issue. It is best practice though to avoid them as they can:\n\n\n- cause an increase in computations (and unnecessary gas consumption)\n- indicate bugs or malformed data structures and they are generally a sign of poor code quality\n- cause code noise and decrease readability of the code,
- Remediation: Remove all unused variables from the code base.

## M-32: Unexpected Ether balance,
- Description: Contracts can behave erroneously when they strictly assume a specific Ether balance. It is always possible to forcibly send ether to a contract (without triggering its fallback function), using selfdestruct, or by mining to the account. In the worst case scenario this could lead to DOS conditions that might render the contract unusable.,
- Remediation: Avoid strict equality checks for the Ether balance in a contract.

## M-33: Hash Collisions With Multiple Variable Length Arguments,
- Description: Using `abi.encodePacked()` with multiple variable length arguments can, in certain situations, lead to a hash collision. Since `abi.encodePacked()` packs all elements in order regardless of whether they're part of an array, you can move elements between arrays and, so long as all elements are in the same order, it will return the same encoding. In a signature verification situation, an attacker could exploit this by modifying the position of elements in a previous function call to effectively bypass authorization.,
- Remediation: When using `abi.encodePacked()`, it's crucial to ensure that a matching signature cannot be achieved using different parameters. To do so, either do not allow users access to parameters used in `abi.encodePacked()`, or use fixed length arrays. Alternatively, you can simply use `abi.encode()` instead.\n\n\nIt is also recommended that you use replay protection (see [SWC-121](./SWC-121.md)), although an attacker can still bypass this by [front-running](./SWC-114.md).

## M-34: Message call with hardcoded gas amount,
- Description: The `transfer()` and `send()` functions forward a fixed amount of 2300 gas. Historically, it has often been recommended to use these functions for value transfers to guard against reentrancy attacks. However, the gas cost of EVM instructions may change significantly during hard forks which may break already deployed contract systems that make fixed assumptions about gas costs.  For example. [EIP 1884](https://eips.ethereum.org/EIPS/eip-1884) broke several existing smart contracts due to a cost increase of the SLOAD instruction.,
- Remediation: Avoid the use of `transfer()` and `send()` and do not otherwise specify a fixed amount of gas when performing calls. Use `.call.value(...)(\\)` instead. Use the checks-effects-interactions pattern and/or reentrancy locks to prevent reentrancy attacks.

## M-35:Code With No Effects,
- Description: In Solidity, it's possible to write code that does not produce the intended effects. Currently, the solidity compiler will not return a warning for effect-free code. This can lead to the introduction of \dead\ code that does not properly performing an intended action.\n\n\nFor example, it's easy to miss the trailing parentheses in `msg.sender.call.value(address(this).balance)(\\);`, which could lead to a function proceeding without transferring funds to `msg.sender`. Although, this should be avoided by [checking the return value of the call](./SWC-104.md).,
- Remediation: It's important to carefully ensure that your contract works as intended. Write  unit tests to verify correct behaviour of the code.

## M-36: Unencrypted Private Data On-Chain,
- Description: It is a common misconception that `private` type variables cannot be read. Even if your contract is not published, attackers can look at contract transactions to determine values stored in the state of the contract. For this reason, it's important that unencrypted private data is not stored in the contract code or state.,
- Remediation: Any private data should either be stored off-chain, or carefully encrypted.

## M-37: require() / revert() statements should have descriptive reason strings

## M-38: Event is missing indexed fields
- Description: Index event fields make the field more quickly accessible to off-chain tools that parse events. However, note that each index field costs extra gas during emission, so it's not necessarily best to index the maximum allowed per event (three fields). Each event should use three indexed fields if there are three or more fields, and gas usage is not particularly of concern for the events in question. If there are fewer than three fields, all of the fields should be indexed.

## M-39: Constants should be defined rather than using magic numbers

## M-40: Functions not used internally could be marked external

## M-41: Return values of approve() not checked	
- Description: Not all IERC20 implementations revert() when there's a failure in approve(). The function signature has a boolean return value and they indicate errors that way instead. By not checking the return value, operations that should have marked as failed, may potentially go through without actually approving anything.

## M-42 bi.encodePacked() should not be used with dynamic types when passing the result to a hash function such as keccak256()
- Description: Use abi.encode() instead which will pad items to 32 bytes, which will prevent hash collisions (e.g. abi.encodePacked(0x123,0x456) => 0x123456 => abi.encodePacked(0x1,0x23456), but abi.encode(0x123,0x456) => 0x0...1230...456). Unless there is a compelling reason, abi.encode should be preferred. If there is only one argument to abi.encodePacked() it can often be cast to bytes() or bytes32() instead. If all arguments are strings and or bytes, bytes.concat() should be used instead

## M-43 Unspecified compiler version

## M-44 Unsafe ERC20 operation(s)
```solidity
ggp.approve(address(staking), restakeAmt);
```
## M-45 Centralization Risk for trusted owners
- Description: The contract is owned by a single address. This address can change the contract's behavior and steal funds. The contract should be owned by a multi-sig contract or a decentralized governance mechanism.
