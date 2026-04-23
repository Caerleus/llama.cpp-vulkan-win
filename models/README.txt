# Model Download Guide

To use this software, you need to download a model in GGUF format.

## Where to find models
I highly recommend visiting **Hugging Face** (huggingface.co) in the **Models** section.
* Use the search filters to find models compatible with **llama.cpp**.
* Look for files with the **.gguf** extension.

## How to choose the right size
The model size you can run depends on your hardware:
* **VRAM Consideration:** Choose a model size based on the memory of your graphics card.
* **Multi-GPU Note:** If you have two graphics cards, you should base your choice on the VRAM of a **single card** to ensure stability and optimal performance.
* **Quantization:** I suggest "Q4_K_M" or "Q5_K_M" for a good balance between intelligence and speed.

## Performance vs. Precision
While "quantized" models (like Q4 or Q5) are faster and save VRAM, you can also find high-precision versions:
* **Q8 / F16 Models:** Many community creators on Hugging Face provide small-parameter models (e.g., 3B or 8B) in Q8 or F16 formats. 
* **When to use them:** Use these if you have enough VRAM and prioritize the highest possible output quality and intelligence over generation speed.

## Compatibility
* This build is optimized for modern architectures like **Llama 3**.
* Ensure the model is "splittable" (standard GGUF format) to allow the engine to distribute the workload correctly across the available layers.

## Setup
Once downloaded, place your `.gguf` file in this folder and update your launch script with the correct filename.