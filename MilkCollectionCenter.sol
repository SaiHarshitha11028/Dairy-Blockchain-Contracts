// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MilkCollectionCenter {
    uint256 private totalMilk;
    // int private farmerId;
    uint256 public centerId;
    uint256 private quality;
    mapping(uint256 => uint256[3][]) private data;
    string private result = "";
    uint private time;

    constructor(uint256 _centerId) {
        centerId = _centerId;
    }

    function checkQuality() public pure returns (uint256) {
        return 5;
    }

    function addMilk(uint256 _farmerId, uint256 _quantity, uint fatPercent) public {
        quality = checkQuality();
        require(fatPercent == 5);
        totalMilk += _quantity;
        data[_farmerId].push([block.timestamp,_quantity, fatPercent]);
    }

    function getDataByID(uint256 _farmerId) public view returns (uint256[3][] memory){
        return data[_farmerId];
    }

    function getTotalQuantity() public view returns (uint256) {
        return totalMilk;
    }

    function uint2str(uint256 _i) internal pure returns (string memory _uintAsString){
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
    function setMilkZero() public {
        totalMilk = 0;
    }

    function exportMilk() public returns (string memory) {
        time=block.timestamp;
        result = string(abi.encodePacked("Center Id : ", uint2str(centerId), " Total Quantity : ",uint2str(totalMilk), "  Time : ", uint2str(time)));
        return result;
    }
}
