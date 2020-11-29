"use static";

module.exports = {
  entry: {
    InDesign: "./InDesign.py",
  },
  module: {
    rules: [
      {
        test: /\.py$/,
        loader: "transcrypt-loader",
        options: {},
      },
    ],
  },
  target: "node",
};
