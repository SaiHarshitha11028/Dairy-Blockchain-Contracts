const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const {interface, bytecode} = require('./compilePacking');

const provider = new HDWalletProvider(
    'barrel wise home outdoor amused enrich lunch then envelope round attract core',
    'https://rinkeby.infura.io/v3/718ecb01b2fc466792ab0ca3dcae7abe'    
);  //mnemonic, api

const web3 = new Web3(provider);
const deploy = async()=>{
    const accounts = await web3.eth.getAccounts();
    console.log("deploying contract from account : ",accounts[0]);

    const result = await new web3.eth.Contract(interface).deploy({data: bytecode, arguments:[10]}).send({gas:'10000000', from: accounts[0]});
    console.log(JSON.stringify(interface));
    console.log("Contract deployed to : ", result.options.address);
};
deploy();