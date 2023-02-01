// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

    uint public numOfFunders;
    mapping(address => bool) private funders;

    receive() external payable {}

    function addFunds() external payable{
        address funder = msg.sender;
        if (!funders[funder]) {
            numOfFunders++;
            funders[funder] = true;
        }
    }

}

//instance.addFunds({from: accounts[0], values:"2"})