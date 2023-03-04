// The predicateType field must match this string
predicateType: "https://slsa.dev/provenance/v0.2"

predicate: {
  // This condition verifies that the builder is the builder we
  // expect and trust. The following condition can be used
  // unmodified. It verifies that the builder is the container
  // workflow.
  builder: {
    id: =~"^https://github.com/albasystems/slsa-provenance-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v[0-9]+.[0-9]+.[0-9]+$"
  }
  invocation: {
    configSource: {
      // This condition verifies the entrypoint of the workflow.
      // Replace with the relative path to your workflow in your
      // repository.
      entryPoint: ".github/workflows/build.yml"

      // This condition verifies that the image was generated from
      // the source repository we expect.
      uri: =~"^git\\+https://github.com/albasystems/hello-slsa@refs/heads/main"
    }
  }
}