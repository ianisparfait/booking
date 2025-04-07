<?php

namespace App\Service;

use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\Mapping\MappingException;
use ReflectionException;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class EntityService
{
    private EntityManagerInterface $em;
    private JsonService $js;

    public function __construct(EntityManagerInterface $em, JsonService $js)
    {
        $this->em = $em;
        $this->js = $js;
    }

    public function CreateOrUpdate(FormInterface $form, $entity, $data, string $entityClass): JsonResponse {
        $form->submit($data);

        if ($form->isSubmitted() && $form->isValid()) {
            $formData = $form->getData();

            $this->em->persist($formData);
            $this->em->flush();

            $entity = $this->js->objectToJson($entity, $entityClass);

            return new JsonResponse($entity, Response::HTTP_OK);
        }

        return new JsonResponse($entity, Response::HTTP_OK);
    }

    public function checkFields(array $data, string $entityClass): bool
    {
        $classString = sprintf('App\\Entity\\%s', ucfirst($entityClass));
        $metadata = $this->em->getClassMetadata($classString);

        foreach ($metadata->getFieldNames() as $field) {
            if ($metadata->isIdentifier($field)) {
                continue;
            }

            try {
                $fieldMapping = $metadata->getFieldMapping($field);
            } catch (MappingException $e) {
                return false;
            }
            $isNullable = $fieldMapping['nullable'] ?? false;

            if (!$isNullable && !isset($data[$field])) {
                return false;
            }
        }

        return true;
    }

}
