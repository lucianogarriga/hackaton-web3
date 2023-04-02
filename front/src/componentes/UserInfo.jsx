import React, { useEffect } from "react";
import { useAccount, useContractRead, useEnsName } from "wagmi";
import { settings } from "../paginas/contrato/settings";
import "./UserInfo.css";

const UserInfo = () => {
  const { address, isConnected } = useAccount();
  const { data: ensName } = useEnsName({ address });
  const { addressContract, abi } = settings;

  const { data, isLoading, isError } = useContractRead({
    address: addressContract,
    abi: abi,
    functionName: "getBalance",
  });



  useEffect(() => {
    console.log(data);
  }, [data]);

  const shortenAddress = (address) => {
    if (!address) return "";
    return address.slice(0, 6) + "..." + address.slice(-4);
  };

  return (
    <section className="conteiner-connected">
      <p>User X </p>
      <p>
        Connected to:{" "}
        <span className="userAddress">{shortenAddress(address)}</span>
      </p>
    </section>
  );
};

export default UserInfo;
