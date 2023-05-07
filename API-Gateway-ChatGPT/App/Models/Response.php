<?php

    declare(strict_types=1);

    namespace Mario\ApiGatewayChatGpt\Models;

    class Response {
        public mixed $data;
        public bool $isSuccess;
    
        public function __construct(mixed $data, bool $isSuccess) {
            $this->data = $data;
            $this->isSuccess = $isSuccess;
        }
    }