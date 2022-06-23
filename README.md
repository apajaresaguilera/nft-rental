# NFT Rental
NFT rental allows users to lend their NFTs in exchange for ether. Previous to executing the lending, both the lender and the borrower determine a fixed amount of time to lend the token, as well as the price. The token is then stored in a custodial Smart Contract, which holds the token and allows the conditions of the agreement to be fulfilled using a multisig.

## Key concepts
### Digital signatures
Signatures are used as a proof of ownership mechanism. We can use them to verify that a message is the same one as the one that the author signed, or to prove that you own an address. In order to do this, cryptographic algorithms are used. In the case of Bitcoin and Ethereum, the [ECDSA (Elliptic Curve Digital Signature Algorithm)](https://www.youtube.com/watch?v=dCvB-mhkT0w&ab_channel=F5DevCentral) is used.   
In order to create a digital signature, we need three main components as input:  
* An input message
* A private key
* A random secret  

 The final signature is formed by three main components: two integers (_r_ and _s_) and a recovery identifier (_v_), which can be represented by the following struct:
 ```
struct Signature {
        uint32 r;
        uint32 s;
        uint8 v;
    }
 ```
The process to sign an Ethereum transaction is simillar. The transactions are [RLP encoded](https://ethereum.org/en/developers/docs/data-structures-and-encoding/rlp/). In order to sign and encode a transaction, we'll neeed the _r_, _s_ and _v_ values that form the signature, as well as the transaction parameters (nonce, gas price, gas limit, to, value and data). 
The signing and encoding process is as follows:  
1. First of all, we must encode the transaction parameters: RLP(nonce, gasPrice, gasLimit, to, value, data, chainId, 0, 0)
2. Then, we'll generate the Keccak256 for the previously RLP-encoded transaction
3. After genereting the Keccak256 hash, we'll sign it using ECDSA (remember the _r_, _s_ and _v_ values, right?)
4. Finally, we'll encode the signed transaction again: RLP(nonce, gasPrice, gasLimit, to, value, data, v, r, s)  

### EIP-712



