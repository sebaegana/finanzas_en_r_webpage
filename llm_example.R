library(ellmer)

chat_ollama(
  system_prompt = NULL,
  base_url = "http://localhost:11434",
  model = "llama2",
  seed = NULL,
  api_args = list(),
  echo = NULL,
  api_key = NULL
)

models_ollama(base_url = "http://localhost:11434")

chat <- chat_ollama(
  base_url = "http://localhost:11434",
  model = "gemma3"
)

chat$chat("tell me a joke")

