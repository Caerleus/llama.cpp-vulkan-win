This .bat script is a small masterpiece of practicality: it transforms a complex command‑line tool into a very intuitive menu‑based interface. It’s perfect for users with specific hardware setups (like your dual RX 580 configuration) who still want the freedom to choose how to use their resources.

Below is an explanation of how it works, divided into logical sections:

Preparation and Relative Paths
The script begins by setting up the working environment.

Security and Portability: It uses %~dp0 (the folder where the script is located) to define paths. This means the user can move the folder anywhere and the script will always work without manually configuring Windows paths.

Self‑maintenance: If the "models" folder does not exist, the script automatically creates it, guiding the user on where to place .gguf files.

Automatic Model Selection
Instead of forcing the user to type the filename (an error‑prone operation), the script scans the folder:

Dynamic Scanning: It searches for all files ending in .gguf.

Numbered Menu: It assigns a number to each model found and displays them on screen.

Simple Choice: The user only needs to type the corresponding number (e.g., "1" or "2"), and the script stores the full path of the selected model.

Intelligent Hardware Management (Vulkan)
This is the most advanced part of the script, dedicated to optimizing computing power. It offers four execution modes:

Option | Backend | Description

CPU | Processor | Uses only system RAM and the CPU. Useful if you want to keep the GPU free for other tasks.

GPU 0 | Vulkan | Uses the first graphics card detected by the system.

GPU 1 | Vulkan | Uses the second graphics card (essential in Dual‑GPU systems).

Multi‑GPU | Vulkan | The most powerful mode: splits the workload between GPU 1 and GPU 0 using the command --tensor-split 1,1.

Default Configuration Parameters
To ensure stability, the script sets “safe” but performant values:

Context (CTX=4096): Defines how long the conversation memory can be.

Threads (THREADS=8): Optimizes CPU usage during computation.

Network: Sets the server on port 11434 (the same standard used by tools like Ollama), making it accessible locally or over the network.

Launch and Control
Once the choices are made, the script builds the final %CMD% command and executes it. It also shows a summary on screen to confirm which backend is actually running, avoiding any doubt about whether the GPU is active or not.