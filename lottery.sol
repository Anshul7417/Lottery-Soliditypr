// SPDX-License_Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;


contract lottery{
    address public manager;
    address payable[] public participants;

    constructor(){
        manager=msg.sender;
    }

    receive() external payable{  //special one time used to transfer ether to contract
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}