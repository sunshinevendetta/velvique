import type { MetadataRoute } from "next";
import { COPY } from "@velvique/content";

/** Home-screen install: black ground, the blue V. */
export default function manifest(): MetadataRoute.Manifest {
  return {
    name: "Velvique",
    short_name: "Velvique",
    description: COPY.ES.meta.description,
    start_url: "/",
    display: "standalone",
    background_color: "#000000",
    theme_color: "#000000",
    icons: [
      { src: "/icon.png", sizes: "512x512", type: "image/png" },
      { src: "/apple-icon.png", sizes: "180x180", type: "image/png" },
    ],
  };
}
