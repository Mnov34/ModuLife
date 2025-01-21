# ModuLife Architecture & Contribution Instruction

Welcome to ModuLife! 

**Important**: Before contributing, please read the following to understand our architecture:

1. **Separation of Concerns**: 
   - The _main app_ focuses only on UI (screens, routes). 
   - Each feature (e.g., "Todos", "Notes") lives in its own package, containing the BLoCs, repositories, models, and whatnot for that feature.

2. **BLoC & Repositories**: 
   - We rely on the BLoC pattern to handle state management in each package. 
   - Repositories manage data persistence, usually with SharedPreferences or other local storage.

3. **Dependency & Versioning**:
   - Always consult the `pubspec.yaml` for version constraints. 
   - Make sure not to break other packages' dependencies.

4. **Folder vs. Todo**:
   - Currently, "Folder" BLoC and "Todo" BLoC are in `modulife_todos`. 
   - We use a parent-child relationship (folder ID inside the todo) to link them. 
   - For deeper nesting, we will implement a Composite-like approach in the future.

5. **Coding Style & Linting**:
   - Follow the existing lint rules if provided. 
   - Write well-documented code. 
   - Provide tests where applicable.

6. **Contribution Workflow**:
   - Fork the repo and create a branch for your change. 
   - Make sure your changes do not break existing code. 
   - Document major changes in the relevant `README.md` or the PR description.

If you have questions about the domain logic or how the BLoCs interact, see the package-level `README`s or open an issue. 

Thanks for contributing to **ModuLife**!
