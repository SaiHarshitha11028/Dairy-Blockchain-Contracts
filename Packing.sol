// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Packing{
    uint public totalQuantity;
    uint public noOfPackets;
    uint private time;
    string private res="";
    string public prevData;
    mapping(uint256 => uint256[2][]) private data;
    
    function addMilk(uint quantity) public{
        totalQuantity+=quantity;
    }
    
    function pack() public returns (uint){
         noOfPackets+=totalQuantity*2;
         totalQuantity=0;
         return noOfPackets;
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
    
    function getDataById(uint agentID) public view returns (uint[2][] memory){
        return data[agentID];
    }

    function setPrevData(string memory info) public{
        prevData=info;
    }

    function getNoOfPackets() public view returns (uint){
        return noOfPackets;
    }
    
    function delivaryTo(uint agentID, uint packets) public{
        data[agentID].push([time,packets]);
        noOfPackets-=packets;
    }

    function export(uint agentID, uint packets) public returns (string memory){
        time=block.timestamp;
        res=string(abi.encodePacked(prevData," Packing : "," Agent ID : ", uint2str(agentID), " No Of Packets : ", uint2str(packets), " Time : ", uint2str(time)));
        return res;
    }
}