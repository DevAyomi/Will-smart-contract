//this is where our code goes
//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

contract Will {
    address owner;
    uint fortune;
    bool isDeceased;

    constructor() payable {
        owner = msg.sender;  //addresss that is. being called
        fortune = msg.value; //value. tells us amount that is being sent
        isDeceased = false;
    }

    //create a modifie so that the only person that can call the contract is the owner
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    modifier mustBeDeceased () {
        require(isDeceased == true);
        _;
    }

    address payable [] familyWallets;

    //mapp through inheritance
    mapping(address => uint) inheritance;

    //set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    //Pay each family member based on their wallet
    function payout() private mustBeDeceased {
        for (uint i = 0; i < familyWallets.length; i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    //Oracle switch simulation
    function hasDeaceased () public onlyOwner{
        isDeceased = true;
        payout();
    }

}