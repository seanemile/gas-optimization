// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Tip3a.sol";
import "../src/Tip3b.sol";

import "forge-std/Test.sol";

contract Tip2Test is Test {
    Tip3a public tip3a;
    Tip3b public tip3b;

    function setUp() public {
        tip3a = new Tip3a();
        tip3b = new Tip3b();
    }

    function testTip3() public view {
        tip3a.variable1();
        tip3b.variable1();
    }
}
