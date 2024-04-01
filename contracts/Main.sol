// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Diam is Ownable, ERC20Permit {
    using SafeMath for uint256;

    uint256 public ownerNounce;

    constructor() ERC20("DIAM", "DIAM") ERC20Permit("DIAM") {}

    //DW03 - zero amount request
    //DW091 - Invalid hash
    //DW02 - unauthorized
    function mint(
        uint256 amount,
        bytes32 _hash,
        uint8 _v,
        bytes32 _r,
        bytes32 _s,
        uint256 deadline
    ) external {
        require(amount > 0, "DW03");
        require(block.timestamp <= deadline, "DW092");
        require(
            keccak256(
                abi.encodePacked(
                    msg.sender,
                    amount,
                    ownerNounce,
                    block.chainid,
                    deadline,
                    address(this)
                )
            ) == _hash,
            "DW091"
        );

        bytes32 messageDigest = keccak256(
            abi.encodePacked(
                "\x19Ethereum Signed Message:\n32",
                keccak256(
                    abi.encodePacked(
                        msg.sender,
                        amount,
                        ownerNounce,
                        block.chainid,
                        deadline,
                        address(this)
                    )
                )
            )
        );

        address signer = ECDSA.recover(messageDigest, _v, _r, _s);

        require(signer == owner(), "DW02");

        ownerNounce++;

        _mint(_msgSender(), amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
