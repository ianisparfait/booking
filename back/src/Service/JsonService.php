<?php

namespace App\Service;

use Doctrine\ORM\EntityManagerInterface;
use ReflectionException;

class JsonService
{
    private EntityManagerInterface $em;

    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    private function getGetterName(string $field): string
    {
        return 'get' . str_replace(' ', '', ucwords(str_replace('_', ' ', $field)));
    }

    public function arrayToJson(array $entities, string $entityClass): array | string {
        $data = [];
        $classString = sprintf('App\\Entity\\%s', ucfirst($entityClass));

        $metadata = $this->em->getClassMetadata($classString);
        $fields = $metadata->getFieldNames();

        foreach ($entities as $entity) {
            $entityData = [];
            foreach ($fields as $field) {
                try {
                    $getter = $this->getGetterName($field);
                    $entityData[$field] = $metadata->getReflectionClass()->getMethod($getter)->invoke($entity);
                } catch (ReflectionException $e) {
                    return $e->getMessage();
                }
            }
            $data[] = $entityData;
        }

        return $data;
    }

    public function objectToJson(object $entity, string $entityClass): array | string {
        $entityData = [];

        $classString = sprintf('App\\Entity\\%s', ucfirst($entityClass));

        $metadata = $this->em->getClassMetadata($classString);
        $fields = $metadata->getFieldNames();

        if (!$entity) {
            return "Entity not found";
        }

        foreach ($fields as $field) {
            try {
                $getter = $this->getGetterName($field);
                $entityData[$field] = $metadata->getReflectionClass()->getMethod($getter)->invoke($entity);
            } catch (ReflectionException $e) {
                return $e->getMessage();
            }
        }

        return $entityData;
    }
}
