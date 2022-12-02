Smart contracts for blockchain-based authentication system

## 1.Install

### npm

```
npm install
```

### yarn

```
yarn install
```

## 2.Compile

```sh
npx hardhat compile
```

## 3.Deployment

### testnet

```
npx hardhat run scripts/deploy.js --network testnet
```

### mainnet

```
npx hardhat run scripts/deploy.js --network mainnet
```

## Note
You need an environment variable file (.env) containing the following variables:

```
TESTNET_RPC_URL=
MAINNET_RPC_URL=
PRIVATE_KEY=
```