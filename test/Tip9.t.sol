// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Tip9.sol";

import "forge-std/Test.sol";

contract TestTip9 is Test {
    Tip9 public tip9;

    function setUp() public {
        tip9 = new Tip9();
    }

    function testTip3() public view {
        tip9.owner1();
        tip9.owner2();
    }
}
