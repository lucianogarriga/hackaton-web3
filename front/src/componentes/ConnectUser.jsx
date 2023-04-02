import React, { useEffect, useState } from "react";
import { useConnect, useDisconnect } from "wagmi";
import { InjectedConnector } from "wagmi/connectors/injected";
import "./ConnectUser.css";
import { SeccionUsuario } from "./SeccionUsuario";

const ConnectUser = ({
  setEstaConectado,
  estaConectado,
  setAddressUser,
  setIsLoading,
}) => {
  const { disconnect } = useDisconnect();
  const { connect, data } = useConnect({
    connector: new InjectedConnector(),
  });
  const [address, setAddress] = useState("");

  useEffect(() => {
    setIsLoading(true);
    if (data) {
      setAddress(data.account);
    }
    return setIsLoading(false);
  }, [data]);

  return (
    <div>
      {estaConectado ? (
        <>
          <SeccionUsuario />
          <button
            onClick={() => {
              disconnect();
              setEstaConectado(false);
              setAddressUser(address);
            }}
          >
            Disconnect
          </button>
        </>
      ) : (
        <button
          onClick={() => {
            connect();
            setEstaConectado(true);
            setAddressUser("");
          }}
        >
          Connect Wallet
        </button>
      )}
    </div>
  );
};

export default ConnectUser;
