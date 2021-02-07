// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.10;

contract AddressStorage {
    mapping(bytes32 => address) private _addresses;

    function getAddress(bytes32 key) public view returns (address) {
        address result = _addresses[key];
        require(result != address(0), "AddressStorage: Address not found");
        return result;
    }

    function _setAddress(bytes32 key, address value) internal {
        _addresses[key] = value;
    }

}
