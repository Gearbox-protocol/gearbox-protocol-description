// SPDX-License-Identifier: MIT
// Gearbox. Uncollateralized protocol for margin trading
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../repository/AddressRepository.sol";
import "hardhat/console.sol";

/**
 * @title Vault
 * @author Mikhail Lazarev
 * @notice This vault contract accepts tokens & eth from user to pool pair.
           It also emit events which is read on Substrate node.
 * @dev Do not use in mainnet.
 */
contract Vault is Ownable {
    /// @dev Token address for vault asset
    address private _tokenAddress;

    // Repositories
    AddressRepository private _addressRepository;

    // Liquidity pool
    event AddLiquidity(address indexed sender, uint256 amount);
    event RemoveLiquidity(address indexed sender, uint256 amount);

    constructor(address addressRepository) public {
        _addressRepository = AddressRepository(addressRepository);
        _tokenAddress = _addressRepository.getGToken();
    }

    function addLiquidity(uint256 amount) external {
        ERC20(_tokenAddress).transferFrom(msg.sender, address(this), amount);
        emit AddLiquidity(msg.sender, amount);
    }

    function removeLiquidity(uint256 amount) external {
        emit RemoveLiquidity(msg.sender, amount);
    }
}
