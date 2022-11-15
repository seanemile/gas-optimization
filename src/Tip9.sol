// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Tip9 {
    /// The owner is set during construction time, and never changed afterwards.
    address public owner1 = msg.sender;

    /// The owner is set during construction time, and never changed afterwards.
    address public immutable owner2 = msg.sender;
}
