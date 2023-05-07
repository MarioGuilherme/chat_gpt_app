<?php

    declare(strict_types=1);

    namespace Mario\ApiGatewayChatGpt\Models;

    class Log {
        public string $error;
        public string $date;
        public string $ip;

        public function __construct(string $error, string $date, string $ip) {
            $this->error = $error;
            $this->date = $date;
            $this->ip = $ip;
        }

        public function __toString() {
            return "{$this->error}||{$this->date}||{$this->ip}";
        }
    }