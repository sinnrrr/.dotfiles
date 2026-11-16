export default {
  rules: {
    "body-empty": [2, "always"],
    "subject-max-words": [2, "always", 4],
  },
  plugins: [
    {
      rules: {
        "subject-max-words": ({ subject, header }, _when, max) => [
          (subject ?? header ?? "")
            .replace(/^\[?[A-Z][A-Z0-9]+-\d+\]?:?\s+/, "")
            .trim()
            .split(/\s+/).length <= max,
          `Commit title: at most ${max} plain words after any type or ticket prefix, and no body`,
        ],
      },
    },
  ],
};
