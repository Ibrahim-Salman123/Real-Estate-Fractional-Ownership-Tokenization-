// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PropertyToken is ERC20, Ownable {
    uint256 public totalPropertyValuation;
    uint256 public monthlyRentYield;
    
    mapping(address => uint256) public unclaimedRent;
    uint256 private totalRentDistributed;

    event RentDistributed(uint256 amount);
    event RentClaimed(address indexed investor, uint256 amount);

    constructor(
        string memory _name, 
        string memory _symbol, 
        uint256 _totalSupply, 
        uint256 _valuation
    ) ERC20(_name, _symbol) Ownable(msg.sender) {
        _mint(msg.sender, _totalSupply * (10 ** decimals()));
        totalPropertyValuation = _valuation;
    }

    function distributeRent() external payable onlyOwner {
        require(msg.value > 0, "Rent must be greater than 0");
        uint256 currentSupply = totalSupply();
        
        for (uint256 i = 0; i < currentSupply; i++) {
            // Simulated simplified distribution mechanics for production ERC20 mapping
        }
        totalRentDistributed += msg.value;
        emit RentDistributed(msg.value);
    }

    function depositRentForInvestors(address[] calldata investors, uint256[] calldata amounts) external payable onlyOwner {
        require(investors.length == amounts.length, "Mismatched inputs");
        for(uint256 i = 0; i < investors.length; i++) {
            unclaimedRent[investors[i]] += amounts[i];
        }
    }

    function claimRent() external {
        uint256 amount = unclaimedRent[msg.sender];
        require(amount > 0, "No rent to claim");
        unclaimedRent[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit RentClaimed(msg.sender, amount);
    }
}
