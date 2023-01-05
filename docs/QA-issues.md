Table of content

# Quality assurance issues
## QA-1: require() / revert() statements should have descriptive reason strings

## QA-2: Event is missing indexed fields
- Description: Index event fields make the field more quickly accessible to off-chain tools that parse events. However, note that each index field costs extra gas during emission, so it's not necessarily best to index the maximum allowed per event (three fields). Each event should use three indexed fields if there are three or more fields, and gas usage is not particularly of concern for the events in question. If there are fewer than three fields, all of the fields should be indexed.
## QA-3: Constants should be defined rather than using magic numbers

## QA-4: Functions not used internally could be marked external

## QA-5: Return values of approve() not checked	
- Description: Not all IERC20 implementations revert() when there's a failure in approve(). The function signature has a boolean return value and they indicate errors that way instead. By not checking the return value, operations that should have marked as failed, may potentially go through without actually approving anything.

# Low level issues
## L-1 bi.encodePacked() should not be used with dynamic types when passing the result to a hash function such as keccak256()
- Description: Use abi.encode() instead which will pad items to 32 bytes, which will prevent hash collisions (e.g. abi.encodePacked(0x123,0x456) => 0x123456 => abi.encodePacked(0x1,0x23456), but abi.encode(0x123,0x456) => 0x0...1230...456). "Unless there is a compelling reason, abi.encode should be preferred". If there is only one argument to abi.encodePacked() it can often be cast to bytes() or bytes32() instead. If all arguments are strings and or bytes, bytes.concat() should be used instead

## L-2 Unspecified compiler version
## L-3 Unsafe ERC20 operation(s)
```solidity
ggp.approve(address(staking), restakeAmt);
```
# Medium level issues

## M-1 Centralization Risk for trusted owners
- Description: The contract is owned by a single address. This address can change the contract's behavior and steal funds. The contract should be owned by a multi-sig contract or a decentralized governance mechanism.
