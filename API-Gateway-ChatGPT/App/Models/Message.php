<?php

    declare(strict_types=1);

    namespace Mario\ApiGatewayChatGpt\Models;

    class Message {
        public string $role;
        public string $content;

        public function __construct(string $role, string $content) {
            $this->role = $role;
            $this->content = $content;
        }
    }