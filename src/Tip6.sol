// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Tip6 {
    function add1(uint256[] memory arr) external pure returns (uint256 sum) {
        uint256 length = arr.length;
        for (uint256 i = 0; i < length; i++) {
            sum += arr[i];
        }
    }

    function add2(uint256[] calldata arr) external pure returns (uint256 sum) {
        uint256 length = arr.length;
        for (uint256 i = 0; i < length; i++) {
            sum += arr[i];
        }
    }
}
