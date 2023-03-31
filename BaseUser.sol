// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract BaseUser{

    string private name;
    
    event EtherReceived(uint amount, address tenantAddress, uint balance);
    event WithdrawalSuccess (bool success, uint addressBalance);

    receive() external payable{ 
        emit EtherReceived(msg.value, address(this), address(this).balance);
    }
    
    fallback() external payable{
        emit EtherReceived(msg.value, address(this), address(this).balance);
     }

    constructor (string memory _name)   {
        name = _name;
    }

    function getUserAddress() public view returns(address){
        return address(this);
    } 
    function showUserBalance() public view returns (uint) {
        return address(this).balance;
    }
}