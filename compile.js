//importing required modules/libraries
const path = require('path');
const fs = require('fs');
const solc = require('solc')

//building path to our contract file
const contrPath = path.resolve(__dirname, 'contracts', 'MilkCollectionCenter.sol');

//reading source code from file
const source = fs.readFileSync(contrPath, 'utf8');

//compiling our source code
const input = {
    language: "Solidity",
    sources: {
        "MilkCollectionCenter.sol": {
            content: source,
        },
    },
    settings: {
        outputSelection: {
            "*": {
                "*": ["*"],
            },
        },
    },
};
// module.exports = JSON.parse(solc.compile(JSON.stringify(input))).contracts["demo.sol"]['Test'];
// console.log(output.contracts["demo.sol"]['Test']);
// console.log(JSON.parse(solc.compile(JSON.stringify(input))).contracts['demo.sol']);
var output=JSON.parse(solc.compile(JSON.stringify(input)));

const interface = output.contracts['MilkCollectionCenter.sol'].MilkCollectionCenter.abi;
const bytecode = output.contracts['MilkCollectionCenter.sol'].MilkCollectionCenter.evm.bytecode.object;


module.exports = {
    interface,
    bytecode,
};