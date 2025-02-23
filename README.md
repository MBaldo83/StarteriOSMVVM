# Demo project to present Gen AI App Builder

Within this repository is the [AIGenerator project](./AIGenerator/Package.swift), a project that uses an AI code editor (currently Aider.chat) to generate code from scripts, and an example [iOS app](https://github.com/MBaldo83/StarteriOSMVVM/tree/sample-generated-project/AppGenAISwiftUIStarter) showing source code written using the AIGenerator.

Note: This is an early stage project in the experimentation phase, there are still quite a few rough edges!

## System requirements

1. Swift Toolchain (Swift 6.0+)
2. Aider Chat CLI
  * The project depends on Aider Chat for generating code through language model prompts.
3. Bash Shell Environment
  * The included build script is written in Bash.
  * You’ll need a Unix-like shell (such as Bash on macOS or Linux, or WSL on Windows) to execute the script:
4. Operating System and Developer Tools
  * macOS Users: Ensure that you have installed Xcode or the Xcode Command Line Tools. This is required not only for building the Swift code but also if you plan to run the companion iOS demo app.
  * Linux Users: Confirm that you have the appropriate build tools and the Swift compiler set up on your system.
  * Windows Users: Although Swift is primarily developed for macOS and Linux, if you’re on Windows, using the Windows Subsystem for Linux (WSL) can serve as a viable alternative.
5. Network Connectivity
  * Since the project interacts with a language model via Aider Chat, you’ll likely need a working internet connection.
  * Ensure that any required API access for the LLM is not blocked by network restrictions.

## Installation

Install Aider Chat following instructions [here](https://aider.chat/docs/install.html).

Ensure that aider is ready to run in your terminal at the root of the project.

## Usage Overview

1. To run the prompts to generate code in your project you will edit the `run()` function of `AiderControl.swift`

In [AiderControl.swift](./AIGenerator/Sources/AiderControl.swift), you'll find the `run()` function where different builder scripts are invoked. Start by choosing the dryRun configuration to see the prompt printed out without executing it.

```swift
var promptPipelineRunner: PromptPipelineRunner = PromptPipelineRunnerFactory.dryRunPipeline()
```

Within the `run()` function of `AiderControl.swift` you edit the scripts you want to run each time. I have provided some 'builders' to demonstrate the idea. For example [runDeckGeneratorViewBuilder](./AIGenerator/Sources/ExampleBuilders/AiderControl+NewViewBuilder.swift) provides an extension to AiderControl with a method to create a 'Deck Generator View' - `runDeckGeneratorViewBuilder()`

2. To run the Generation script from the root of the project run:

```shell
(aider-python-env) % sh ./build_and_run_AI.sh
```

Please Note: The build script compiles the AIGenerator package in release mode and then executes it. For debugging or development, you may want to adjust the script accordingly.

## Gen AI App Builder Components

### The Prompt Pipeline

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
To run a prompt, the pipeline runner requires an implementation of `PromptCreator` and an implementation of `PromptConfig`. 

PromptCreator exposes a method to return a prompt:

```swift
protocol PromptCreator {
    func prompt() -> String
}
```

PromptConfig returns variables use to set up the AI environment

```swift
protocol PromptConfig {
    var filesToAdd: [String] { get }
    var model: String { get }
    var readOnly: String { get }
    var chatHistoryID: String { get }
}
```

### Builder Packages

Within each 'Builder' Package are concrete implementations of PromptCreator and PromptConfig. Often these 2 protocols are implemented by the same struct. For example, [NewViewBuilder](./AIGenerator/Sources/Package_MVVMViewBuilder/NewViewBuilder.swift) implements both protocols. Theses 'Builders' should be considered the encoding of the engineering design for the pattern being implemented. For these Builders to implement the protocols, and actually write the prompts, they depend on a specification of the product requirements.

### Feature Specifications

Feature specifications describe the feature you are building. The attributes of a feature are 'shaped' to provide the information required by the Builders.

For example see [DeckGeneratorViewFeatureSpec](./AIGenerator/Sources/ExampleBuilders/ExampleFeatureSpecs/DeckGeneratorViewFeatureSpec.swift)

```swift
extension MVVM.ViewSpecification {
    static func deckGeneratorViewFeatureSpec() -> MVVM.ViewSpecification {
        .init(
            viewName: "DeckGeneratorView",
            viewFolderPath: "\(AiderControl.Constants.appModuleRoot)Views/",
            models: [
                .init(
                    variableName: "generatedQuestions",
                    modelType: "Question",
                    modelPath: "\(AiderControl.Constants.appModuleRoot)Domain/Question.swift",
                    isCollection: true
                )
            ]
        )
    }
}
```

### Putting it all together:

1. Write a feature spec eg. [DeckGeneratorViewFeatureSpec](./AIGenerator/Sources/ExampleBuilders/ExampleFeatureSpecs/DeckGeneratorViewFeatureSpec.swift)
2. Provide this to something that implements `PromptCreator` and `PromptConfig` eg. [NewViewBuilder](./AIGenerator/Sources/Package_MVVMViewBuilder/NewViewBuilder.swift)
3. Pass these implementations to promptPipelineRunner to execute
4. In entry point - `AiderControl -> run()`, add the script you want to run, and configure global settings like dryRunPipeline / aiderProductionPipeline
5. build and run the script: `sh ./build_and_run_AI.sh`
6. Watch the terminal to see the output (be patient, when it looks like it's doing nothing it might be thinking!)
