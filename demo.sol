pragma solidity ^0.8.0;

contract Test {
    int public data;
    constructor (int d) public{
        data=d;
    }
    function setData(int d) public{
        data=d;
    }
    function getData() public view returns(int){
        return data;
    }
}