# Demo project to present Gen AI App Builder

Within this repository, is the [AIGenerator project](./AIGenerator/Package.swift) and an example [iOS app](./AppGenAISwiftUIStarter/) showing source code written using the AIGenerator.

Note: This is an early stage project in the experimentation phase, there are still quite a few rough edges!

## Installation

Install Aider Chat following instructions [here](https://aider.chat/docs/install.html).

Ensure that aider is ready to run in your terminal at the root of the project.

## Usage Overview

1. To run the prompts to generate code in your project you will edit the `run()` function of `AiderControl.swift`

Within the `run()` function of `AiderControl.swift` you edit the scripts you want to run each time. I have provided some 'builders' to demonstrate the idea. For example [runDeckGeneratorViewBuilder](./AIGenerator/Sources/ExampleBuilders/AiderControl+NewViewBuilder.swift).

It is recommended that you choose the 'dryRun' case in [AiderControl -> var promptPipelineRunner](./AIGenerator/Sources/AiderControl.swift) when first running the project to print without executing the prompt you will be passing to the LLM:

```swift
var promptPipelineRunner: PromptPipelineRunner = PromptPipelineRunnerFactory.dryRunPipeline()
```

2. To run the Generation script from the root of the project run:

```shell
(aider-python-env) % sh ./build_and_run_AI.sh
```

## Gen AI App Builder Components:

You execute the code building prompts by calling the inference method on the `promptPipelineRunner`:

```swift
protocol PromptPipelineRunner {
    func inference(
        using promptCreator: PromptCreator,
        with config: PromptConfig
    )
}
```

For example, calling this method to create a new view:

```swift
func runDeckGeneratorViewBuilder() {
        let viewBuilder = NewViewBuilder(newView: .deckGeneratorViewFeatureSpec())
        promptPipelineRunner.inference(
            using: viewBuilder,
            with: viewBuilder
        )
    }
```
