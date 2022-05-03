 // SPDX-License_Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;


contract lottery{
    address public manager;
    address payable[] public participants;

    constructor(){
        manager=msg.sender;
    }

    receive() external payable{  //special function executes one time used to transfer ether to contract
        require(msg.value == 2 ether);    //if else short form
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager);    // visible to manager only
        return address(this).balance;
    }


    function random() public view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));   // generates random values
    }

    function selectWinner() public payable {
        require(msg.sender == manager);
        require(participants.length>=3);
        uint r = random();
        address payable winner;
        uint index = r % participants.length;
        winner = participants[index];
        winner.transfer(getBalance());
        participants = new address payable[](0);   // resetting after winner announcement.
    }

}