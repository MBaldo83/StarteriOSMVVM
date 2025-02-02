# Demo project to present Gen AI App Builder

Note: This is an early stage project in the experimentation phase, there are still quite a few rough edges!

## Installation

Install Aider Chat following instructions [here](https://aider.chat/docs/install.html).

Ensure that aider is ready to run in your terminal at the root of the project.

## Usage

To run the prompts to generate code in your project you will edit the `run()` function of `AiderControl.swift`

You execute the code building prompts by calling the inference method on the `promptPipelineRunner`:

```
protocol PromptPipelineRunner {
    func inference(
        using promptCreator: PromptCreator,
        with config: PromptConfig
    )
}
```

For example, calling this method to create a new view:

```
func runDeckGeneratorViewBuilder() {
        let viewBuilder = NewViewBuilder(newView: .deckGeneratorViewFeatureSpec())
        promptPipelineRunner.inference(
            using: viewBuilder,
            with: viewBuilder
        )
    }
```
