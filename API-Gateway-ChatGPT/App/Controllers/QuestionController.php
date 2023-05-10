<?php

    namespace Mario\ApiGatewayChatGpt\Controllers;

    use Exception;
    use Mario\ApiGatewayChatGpt\Core\{
        Controller,
        Database,
        StatusCode
    };
    use Mario\ApiGatewayChatGpt\Models\{
        IPAddress,
        UserAgent,
        Message
    };

    class QuestionController extends Controller {
        private Database $repository;

        public function __construct() {
            parent::__construct();
        }

        public function makeAQuestion() {
            $curl = curl_init();

            try {
                if ($_SERVER["REQUEST_METHOD"] != "POST") $this->returnJson(StatusCode::METHOD_NOT_ALLOWED);
                curl_setopt_array($curl, [
                    CURLOPT_URL => API_CHAT_GPT->ENDPOINT,
                    CURLOPT_RETURNTRANSFER => true,
                    CURLOPT_HTTPHEADER => [
                        "Content-Type: application/json",
                        "Authorization: Bearer " . API_CHAT_GPT->API_KEY
                    ],
                    CURLOPT_POST => true,
                    CURLOPT_POSTFIELDS => json_encode([
                        "model" => API_CHAT_GPT->MODEL,
                        "messages" => $this->payload,
                        "temperature" => API_CHAT_GPT->TEMPERATURE
                    ])
                ]);

                (string) $jsonString = curl_exec($curl);
                (int) $httpStatusCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);

                if(curl_errno($curl) || $httpStatusCode != 200)
                    throw new Exception("Erro ao enviar a requisição: " . (empty(curl_error($curl)) ? "Status Code: $httpStatusCode" : curl_error($curl)), StatusCode::INTERNAL_ERROR);

                (object) $response = json_decode($jsonString);
                // (object) $response = json_decode(" // Usado quando não há API Key, retornando um json para teste
                //     {
                //         \"id\": \"chatcmpl-6p9XYPYSTTRi0xEviKjjilqrWU2Ve\",
                //         \"object\": \"chat.completion\",
                //         \"created\": 1677649420,
                //         \"model\": \"gpt-3.5-turbo\",
                //         \"usage\": {\"prompt_tokens\": 56, \"completion_tokens\": 31, \"total_tokens\": 87},
                //         \"choices\": [
                //             {
                //                 \"message\": {
                //                     \"role\": \"assistant\",
                //                     \"content\": \"The 2020 World Series was played in Arlington, Texas at the Globe Life Field, which was the new home stadium for the Texas Rangers.\"
                //                 },
                //                 \"finish_reason\": \"stop\",
                //                 \"index\": 0
                //             }
                //         ]
                //     }
                // ");

                (string) $question = $this->payload[count($this->payload) - 1]->content;
                (object) $answer = new Message("assistant", $response->choices[0]->message->content);

                if (REPORTS->QUESTIONS) {
                    $this->repository = new Database();
                    (int) $id_ip_address = $this->repository->select(
                        fields: "id_ip_address",
                        from: "ip_addresses",
                        where: "ip_address = ?",
                        params: [$_SERVER["REMOTE_ADDR"]]
                    )->fetchObject(IPAddress::class)->id_ip_address ?? null;

                    if (!$id_ip_address) $id_ip_address = $this->repository->insert("ip_addresses", ["ip_address" => $_SERVER["REMOTE_ADDR"]]);

                    (int) $id_user_agent = $this->repository->select(
                        fields: "id_user_agent",
                        from: "user_agents",
                        where: "user_agent = ?",
                        params: [$_SERVER["HTTP_USER_AGENT"]]
                    )->fetchObject(UserAgent::class)->id_user_agent ?? null;

                    if (!$id_user_agent) $id_user_agent = $this->repository->insert("user_agents", ["user_agent" => $_SERVER["HTTP_USER_AGENT"]]);
                    $this->repository->insert("questions", [
                        "id_ip_address" => $id_ip_address,
                        "id_user_agent" => $id_user_agent,
                        "question" => $question,
                        "answer" => $answer->content,
                        "date_time" => date("Y-m-d H:i:s")
                    ]);
                };

                $this->returnJson(StatusCode::OK, $answer);
            } catch (Exception $error) {
                $this->saveLog($error->getMessage());
                $this->returnJson($error->getCode(), $error->getMessage());
            } finally {
                curl_close($curl);
                $this->repository = null;
            }
        }
    }