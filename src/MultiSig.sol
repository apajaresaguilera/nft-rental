// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract MultiSig {
    
    //ERRORS
    error InconsistentParamsLength();
    error InvalidSignatureLength();
    error InvalidSignatureVersion();
    
    /// @dev Minimum amount of signatures to allow a transaction
    uint constant public QUORUM = 2;

    mapping(address => bool) signers;

    bytes32 public immutable domainSeparator;

    constructor(
        address[] memory _signers,
        string memory _name
    ) {
        unchecked {
            for (uint256 i; i < _signers.length; i++) signers[_signers[i]] = true;
        }
        domainSeparator = keccak256(
			abi.encode(
				keccak256(
					'EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)'
				),
				keccak256(bytes(_name)),
				keccak256(bytes('1')),
				block.chainid,
				address(this)
			)
		);
    }
    
    function recoverSignerFromSignature(bytes32 hash, bytes memory _signature)
    internal
    pure
    returns (address)
    {
        bytes32 r;
        bytes32 s;
        uint8 v;

        if (_signature.length != 65) revert InvalidSignatureLength();

        // Extract r, s and v values from the signature
        assembly {
            r := mload(add(_signature, 0x20))
            s := mload(add(_signature, 0x40))
            v := byte(0, mload(add(_signature, 0x60)))
        }

        if (v < 27) {
            v += 27;
        }

        if (v != 27 && v != 28) revert InvalidSignatureVersion();
       
        return ecrecover(hash, v, r, s);
        
    }

    function signMessage(address _to, uint256 _amount, uint256 _nonce)
    public
    view
    returns(bytes32) {
        return keccak256(
            abi.encodePacked(
                bytes1(0x19),
                bytes1(0x01),
                domainSeparator,
                keccak256(
                    abi.encode(
                        _to,
                        _amount,
                        _nonce
                    )
                )
            )
        );
    }

   /*  function executeTx(address[] calldata signers, Signature[] calldata signatures) external view returns(bytes32) {
        uint256 signersLength = signers.length;
        uint256 signaturesLength = signatures.length;
        if(signersLength != signaturesLength) revert InconsistentParamsLength();
        unchecked {
            for(uint256 i = 0; i < signatures.length; i++) {
                if()
            }
        }
        return keccak256(
            abi.encodePacked(
                byte(0x19),
                byte(0x01),
                
            );
        );
    } */
}
