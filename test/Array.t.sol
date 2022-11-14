// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Array.sol";
import "forge-std/Test.sol";

contract ArrayTest is Test {
    Array public array;

    function setUp() public {
        array = new Array();
    }

    function testLoop() public view {
        array.loop();
    }

    function testLoop1() public view {
        array.loop1();
    }

    function testLoop2() public view {
        array.loop2();
    }

    function testLoop3() public view {
        array.loop3();
    }
}
