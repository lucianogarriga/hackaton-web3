import { WagmiConfig, createClient, configureChains, mainnet } from "wagmi";
import { publicProvider } from "wagmi/providers/public";
import { polygon, polygonMumbai } from "@wagmi/chains";
import { InjectedConnector } from "wagmi/connectors/injected";

import { PaginaHome } from "./paginas/PaginaHome";

const { chains, provider, webSocketProvider } = configureChains(
  [mainnet, polygon, polygonMumbai],
  [publicProvider()]
);

// Set up client
const client = createClient({
  autoConnect: true,
  connectors: [
    new InjectedConnector({
      chains,
      options: {
        name: "Ripio Portal",
        shimDisconnect: true,
      },
    }),
  ],
  provider,
  webSocketProvider,
});

// Pass client to React Context Provider
function App() {
  return (
    <WagmiConfig client={client}>
      <PaginaHome />
    </WagmiConfig>
  );
}

export default App;
