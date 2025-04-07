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

    public function arrayToJson(array $entities, string $entityClass): array | string {
        $data = [];
        $classString = sprintf('App\\Entity\\%s', ucfirst($entityClass));

        $metadata = $this->em->getClassMetadata($classString);
        $fields = $metadata->getFieldNames();

        foreach ($entities as $entity) {
            $entityData = [];
            foreach ($fields as $field) {
                try {
                    $entityData[$field] = $metadata->getReflectionClass()->getMethod('get' . ucfirst($field))->invoke($entity);
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
                $entityData[$field] = $metadata->getReflectionClass()->getMethod('get' . ucfirst($field))->invoke($entity);
            } catch (ReflectionException $e) {
                return $e->getMessage();
            }
        }

        return $entityData;
    }
}
