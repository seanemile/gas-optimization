// spdx-license-identifier: unlicensed
pragma solidity ^0.8.13;

import "../src/Tip6.sol";
import "forge-std/Test.sol";

contract testTip6 is Test {
    Tip6 public tip6;

    function setUp() public {
        tip6 = new Tip6();
    }

    function testAdd1() public view {
        uint256[] memory arr = new uint256[](5);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;
        arr[3] = 4;
        arr[4] = 5;
        tip6.add1(arr);
    }

    function testAdd2() public view {
        uint256[] memory arr = new uint256[](5);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;
        arr[3] = 4;
        arr[4] = 5;
        tip6.add2(arr);
    }
}
