// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;
import "solmate/tokens/ERC721.sol";
contract RNFT is ERC721{

    constructor() ERC721("RentNFT", "RNFT"){
    }

    function tokenURI(uint256 id) public pure override returns (string memory) {
        return string(abi.encodePacked("", id));
    }
}
