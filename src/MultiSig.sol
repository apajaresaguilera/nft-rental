// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract MultiSig {

    struct Signature {
        uint32 r;
        uint32 s;
        uint8 v;
    }

    function hashTx(Transaction calldata transaction) public view returns(bytes32) {
        return keccak256(
            abi.encodePacked(
                byte(0x19),
                byte(0x01),
                
            );
        );
    }
}
