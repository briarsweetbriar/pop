if (rawLanguages === undefined) { var rawLanguages = [] }
rawLanguages.push({
  name: "Test 1",
  tenses: ["past", "present", "future"],
  conjugations: [
    { key: "fps", value: "First Person Singular" },
    { key: "sps", value: "Second Person Singular" },
    { key: "tps", value: "Third Person Singular" },
    { key: "fpp", value: "First Person Plural" },
    { key: "spp", value: "Second Person Plural" },
    { key: "tpp", value: "Third Person Plural" }
  ],
  verbs: [
    { infinitive: "to test",
      past: {
        fps: "I tested",
        sps: "you tested",
        tps: "he tested",
        fpp: "we tested",
        spp: "y'all tested",
        tpp: "they tested"
      },
      present: {
        fps: "I test",
        sps: "you test",
        tps: "he tests",
        fpp: "we test",
        spp: "y'all test",
        tpp: "they test"
      },
      future: {
        fps: "I will test",
        sps: "you will test",
        tps: "he will test",
        fpp: "we will test",
        spp: "y'all will test",
        tpp: "they will test"
      }
    },
    { infinitive: "to err",
      past: {
        fps: "I erred",
        sps: "you erred",
        tps: "he erred",
        fpp: "we erred",
        spp: "y'all erred",
        tpp: "they erred"
      },
      present: {
        fps: "I err",
        sps: "you err",
        tps: "he errs",
        fpp: "we err",
        spp: "y'all err",
        tpp: "they err"
      },
      future: {
        fps: "I will err",
        sps: "you will err",
        tps: "he will err",
        fpp: "we will err",
        spp: "y'all will err",
        tpp: "they will err"
      }
    }
  ]
});