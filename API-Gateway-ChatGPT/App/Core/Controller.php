<?php

    declare(strict_types=1);

    namespace Mario\ApiGatewayChatGpt\Core;

    use Mario\ApiGatewayChatGpt\Models\{
        Log,
        Response
    };

    class Controller {
        protected mixed $payload;

        public function __construct() {
            $this->payload = json_decode(file_get_contents("php://input"), false);
        }

        protected function saveLog(string $error) : void {
            if (!REPORTS->ERRORS) return;
            (object) $log = new Log(
                error: $error,
                date: date("Y-m-d H:i:s"),
                ip: $_SERVER["REMOTE_ADDR"]
            );
            (object) $handle = fopen(__DIR__ . "/../Logs/errors.log", "a");
            fwrite($handle, "\n$log");
            fclose($handle);
        }

        protected function returnJson(int $statusCode, mixed $data = null) : void {
            header("Content-Type: application/json");
            http_response_code($statusCode);
            die(json_encode(new Response($data, $statusCode >= 200 && $statusCode < 300)));
        }
    }

    abstract class StatusCode {
        const OK = 200;
        const CREATED = 201;
        const METHOD_NOT_ALLOWED = 405;
        const INTERNAL_ERROR = 500;
    }