import React from "react";
import { useConnect, useDisconnect } from "wagmi";
import { InjectedConnector } from "wagmi/connectors/injected";
import "./ConnectUser.css";

const ConnectUser = ({ setEstaConectado, estaConectado }) => {
  const { disconnect } = useDisconnect();
  const { connect } = useConnect({
    connector: new InjectedConnector(),
  });

  return (
    <div>
      {estaConectado ? (
        <button
          onClick={() => {
            disconnect();
            setEstaConectado(false);
          }}
        >
          Disconnect
        </button>
      ) : (
        <button
          onClick={() => {
            connect();
            setEstaConectado(true);
          }}
        >
          Connect Wallet
        </button>
      )}
    </div>
  );
};

export default ConnectUser;
