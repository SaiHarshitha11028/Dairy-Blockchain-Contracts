// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Entry{
    uint private time;
    uint private totalQuantity;
    uint private quantity;
    uint private fatPercentage;
    uint private snf;
    uint[] private quality;
    string private result="";
    string public prevData="Nothing";
    mapping(uint256 => uint256[2][]) private data;
    
    function getDataByCenterID(uint256 centerID) public view returns (uint256[2][] memory){
        return data[centerID];
    }
    
    function addMilk(uint256 centerID, uint256 _quantity) public {
        bool flag=testQuality(9, 5);
        if(flag){
            quantity += _quantity;
            data[centerID].push([block.timestamp,_quantity]);
            totalQuantity += _quantity;
        }
    }
    
    function testQuality(uint _snf, uint _fat) private pure returns(bool){
        if(_snf==9 && _fat==5)
            return true;
        return false;
    }
    
    //=========================================================
    function checkQuality() public returns (uint[2] memory){
        snf= 9;
        fatPercentage= 5;
        return [snf,fatPercentage];
    }
    
    function getTotalQuantity() public view returns (uint256) {
        return totalQuantity;
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
    function setPrevData(string memory info) public returns (string memory){
        prevData = info;
        return prevData;
    }

    function setMilktoZero() public {
        quantity = 0;
    }
    
    function sendInto() public  returns (string memory){
        //time, temp, snf, fatPercentage, 
        time=block.timestamp;
        quality=checkQuality();
        result = string(abi.encodePacked(prevData, " While entering into Processing SNF : ", uint2str(quality[0]), " Fat Percentage : ",uint2str(quality[1]), " Total Quantity : ",uint2str(quantity), " Entry Time : ", uint2str(time)));
        return result;
    }
}
